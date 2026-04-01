//
//  ViewState.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 01/04/2026.
//

import Foundation

enum ViewState<T> {
    case idle
    case loading
    case success(T)
    case failure(String)
}
