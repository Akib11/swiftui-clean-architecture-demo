//
//  Router.swift
//  NetworkLayerSwiftUI
//
//  Created by Akib Quraishi on 26/03/2025.
//

import Foundation
import Combine

protocol NetworkRouter: AnyObject {
    associatedtype EndPoint: EndPointType
    //func cancel()
    //func combineRequest<T: Decodable>(endpoint: EndPoint, responseModel: T.Type) -> AnyPublisher<T, ApiError>
    func asyncRequest<T: Decodable>(endpoint: EndPoint) async throws ->  T
}

class Router<EndPoint: EndPointType>: NetworkRouter {
    
    private let session: URLSession
    private let tokenProvider: TokenProvider?
    
    init(sessionStore: SessionStore? = nil) {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = false
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 120
        self.session = URLSession(configuration: configuration)
        
        /*Uncoment this to provide JWT tokken
        if let sessionStore {
            self.tokenProvider = SessionTokenProvider(session: sessionStore)
        } else {
            self.tokenProvider = nil
        }
        */
        self.tokenProvider = nil
    }
    
    
    func asyncRequest<T: Decodable>(endpoint: EndPoint) async throws -> T {
        do {
            return try await self.asyncRequestProccessor(endpoint: endpoint)

        } catch let apiError as APIError {
            throw apiError

        } catch let urlError as URLError {
            print("URLError code:", urlError.code.rawValue, urlError.code)
            switch urlError.code {
            case .notConnectedToInternet,
                 .networkConnectionLost,
                 .cannotFindHost,
                 .cannotConnectToHost,
                 .dnsLookupFailed:
                throw APIError.notConnectedToInternet

            case .timedOut:
                // If waitsForConnectivity = true, offline often ends up here
                throw APIError.timeOut

            case .secureConnectionFailed, .serverCertificateHasBadDate,
                 .serverCertificateUntrusted, .serverCertificateHasUnknownRoot,
                 .serverCertificateNotYetValid:
                throw APIError.connectionError

            default:
                throw APIError.genericError(title: urlError.localizedDescription)
            }

        } catch {
            // ✅ Anything else (decoding, invalidHttpResponse, etc.)
            throw APIError.genericError(title: error.localizedDescription)
        }
    }

    
    private func asyncRequestProccessor<T: Decodable>(endpoint: EndPoint) async throws ->  T {
        let request = try await RequestBuilder.build(from: endpoint, tokenProvider: tokenProvider)
        NetworkLogger.log(request: request);
            let (data, response) = try await session.data(for: request)
            
        // ✅ If backend says token is invalid/expired -> logout (v1 behaviour)
        /* Uncoment this to provide JWT tokken
               if let http = response as? HTTPURLResponse, http.statusCode == 401 {
                   await tokenProvider?.logout()
               }
         */
        
            return try self.manageResponse(data: data, response: response)
    }
    
    private func manageResponse<T: Decodable>(data: Data, response: URLResponse) throws -> T {
        NetworkLogger.log(response: response as? HTTPURLResponse, data: data, error: nil)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidHttpResponse
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601WithFractionalSeconds

        if (200...299).contains(httpResponse.statusCode) {
            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                throw APIError.decodingError(underlying: error)
            }
        } else {
            throw APIError.unsuccessfulStatusCode(statusCode: httpResponse.statusCode, data: data)
        }

    }

}


extension URLResponse {
    func getStatusCode() -> Int? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        return nil
    }
}



extension JSONDecoder.DateDecodingStrategy {
    static var iso8601WithFractionalSeconds: JSONDecoder.DateDecodingStrategy {
        .custom { decoder in
            let container = try decoder.singleValueContainer()
            let string = try container.decode(String.self)

            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

            if let date = formatter.date(from: string) {
                return date
            }

            // fallback without fractional seconds
            formatter.formatOptions = [.withInternetDateTime]
            if let date = formatter.date(from: string) {
                return date
            }

            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid date: \(string)"
            )
        }
    }
}
