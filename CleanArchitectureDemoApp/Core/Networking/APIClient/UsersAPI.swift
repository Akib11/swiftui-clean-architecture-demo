//
//  UsersAPI.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 01/04/2026.
//

import Foundation

import Foundation

enum UsersAPI {
    case users(page: Int, results: Int)
}

extension UsersAPI: EndPointType {
    
    var baseURL: URL {
        URL(string: "https://randomuser.me")!
    }
    
    var path: String {
        "/api"
    }
    
    var httpMethod: HTTPMethod {
        .get
    }
    
    var task: HTTPTask {
        switch self {
        case .users(let page, let results):
            return .requestParameters(
                bodyParameters: nil,
                bodyEncoding: .urlEncoding,
                urlParameters: [
                    "page": page,
                    "results": results
                ]
            )
        }
    }
    
    var headers: HTTPHeaders? {
        nil
    }
    
    var requiresAuth: Bool {
        false
    }
}
