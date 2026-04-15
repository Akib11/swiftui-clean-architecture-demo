//
//  APIError.swift
//  NetworkLayerSwiftUI
//
//  Created by Akib Quraishi on 26/03/2025.
//

import Foundation

enum APIError: Error {
    case notConnectedToInternet
    case unknownError
    case connectionError
    case invalidCredentials
    case invalidRequest
    case notFound
    case invalidResponse
    case serverError
    case serverUnavailable
    case timeOut
    case unsupportedURL
    case responseDataError
    case invalidHttpResponse
    case decodingDataError
    case unknownBackendError
    case decodingError(underlying: Error)
    case unsuccessfulStatusCode(statusCode: Int, data: Data)
    case genericError(title: String)
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unknownError:
            return "An unknown error occurred."
        case .connectionError:
            return "Unable to connect to the server."
        case .invalidCredentials:
            return "Invalid username or password."
        case .invalidRequest:
            return "The request is invalid."
        case .notFound:
            return "The requested resource was not found."
        case .invalidResponse:
            return "Received an invalid response."
        case .serverError:
            return "Internal server error."
        case .serverUnavailable:
            return "The server is unavailable right now."
        case .timeOut:
            return "The request timed out."
        case .unsupportedURL:
            return "The URL is not supported."
        case .responseDataError:
            return "The response data could not be processed."
        case .invalidHttpResponse:
            return "Invalid HTTP response received."
        case .decodingDataError:
            return "Error decoding the response data."
        case .unknownBackendError:
            return "An unknown error occurred on the server."
        case .decodingError(let underlying):
            return "Failed to decode response: \(underlying.localizedDescription)"
        case .unsuccessfulStatusCode(let statusCode, let data):
            //return "Request failed with status code: \(statusCode)"
            if let env = try? JSONDecoder().decode(ServerErrorEnvelope.self, from: data),
                   let msg = env.errorInfo?.message,
                   !msg.isEmpty {
                    return msg
                }
                return APIError.fromStatusCode(statusCode).errorDescription
        case .notConnectedToInternet:
            return "The Internet connection appears to be offline."
        case .genericError(title: let title):
            return title
        }
    }
}

extension APIError {
    static func fromStatusCode(_ statusCode: Int) -> APIError {
        switch statusCode {
        case 400:
            return .invalidRequest
        case 401:
            return .invalidCredentials
        case 404:
            return .notFound
        case 500:
            return .serverError
        case 503:
            return .serverUnavailable
        default:
            return .unknownBackendError
        }
    }
}


struct ServerErrorEnvelope: Decodable {
    struct ErrorInfo: Decodable {
        let title: String?
        let message: String?
        let stackTrace: String?
    }

    let status: String?
    let errorInfo: ErrorInfo?
}


struct LocalAPIError {
    let title: String
    let desc: String
    var isDisplayed: Bool = false
}
