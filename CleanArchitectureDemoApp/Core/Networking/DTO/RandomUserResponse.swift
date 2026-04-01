//
//  RandomUserResponse.swift
//  CleanArchitectureDemoApp
//
//  Created by Akib Quraishi on 01/04/2026.
//

import Foundation

struct RandomUserResponse: Decodable {
    let results: [RandomUserDTO]
}

struct RandomUserDTO: Decodable {
    let name: NameDTO
    let email: String
    let picture: PictureDTO
}

struct NameDTO: Decodable {
    let first: String
    let last: String
}

struct PictureDTO: Decodable {
    let medium: String
}
