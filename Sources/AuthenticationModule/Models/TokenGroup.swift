//
//  TokenGroup.swift
//  AuthenticationModule
//
//  Created by Simone Samardzhiev on 20.11.24.
//

import Foundation

/// Struct used to get the access and refresh token from the server.
struct TokenGroup: Decodable {
    /// The access token send by the server.
    let accessToken: String
    
    /// The refresh token send by the server.
    let refreshToken: String
}
