//
//  AppEnvironment.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 01/04/2026.
//

import Foundation

public enum AppEnvironment {
    case production, staging, qa

    var host: URL {
        switch self {
        case .production: return URL(string: "https://randomuser.me/")!
        case .staging:    return URL(string: "https://randomuser.me/")!
        case .qa:         return URL(string: "https://randomuser.me/")!
        }
    }
}


public enum APIConfig {
    // single source of truth for whole app
    public static var environment: AppEnvironment = .production

    public static var baseURL: URL { environment.host }
}
