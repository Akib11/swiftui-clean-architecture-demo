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
        case .production: return URL(string: "https://www.landlordhq.app")!
        case .staging:    return URL(string: "https://api.landlordhq.app")!
        case .qa:         return URL(string: "http://192.168.1.81:3000")!
        }
    }
}


public enum APIConfig {
    // single source of truth for whole app
    public static var environment: AppEnvironment = .production

    public static var baseURL: URL { environment.host }
}
