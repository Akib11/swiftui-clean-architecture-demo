//
//  RequestBuilder.swift
//  NetworkLayerSwiftUI
//
//  Created by Akib Quraishi on 25/03/2025.
//

import Foundation

class RequestBuilder {
    
    static func build(from route: EndPointType, tokenProvider: TokenProvider?) async throws -> URLRequest {
        
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        
        // default headers
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // endpoint headers (if you ever use them)
        route.headers?.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        
        // ✅ JWT injection (one place)
        /* Uncoment this to provide JWT tokken
        if route.requiresAuth, let tokenProvider {
            if await tokenProvider.isExpired() {
                await tokenProvider.logout()
                throw APIError.unsuccessfulStatusCode(statusCode: 401, data: Data())
            }
            
            if let token = await tokenProvider.accessToken() {
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            } else {
                throw APIError.unsuccessfulStatusCode(statusCode: 401, data: Data())
            }
        }
         */
        
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestParameters(let bodyParameters,
                                    let bodyEncoding,
                                    let urlParameters):
                
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
                
            case .requestParametersAndHeaders(let bodyParameters,
                                              let bodyEncoding,
                                              let urlParameters,
                                              let additionalHeaders):
                
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate static func configureParameters(bodyParameters: Parameters?,
                                                bodyEncoding: ParameterEncoding,
                                                urlParameters: Parameters?,
                                                request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters, urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
    
    fileprivate static func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
}
