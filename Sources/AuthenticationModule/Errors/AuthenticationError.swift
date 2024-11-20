//
//  AuthenticationError.swift
//  AuthenticationModule
//
//  Created by Simone Samardzhiev on 20.11.24.
//

import Foundation


/// Enumeration that defines errors that can be thrown during authentication.
enum AuthenticationError: Error {
    /// The credentials of the user are wrong.
    case invalidCredentials
    
    /// The password and the confirm password doesn't match.
    case passwordMismatch
    
    /// The email when a user tries to register is already in use.
    case emailInUse
    
    /// The token that was send is invalid.
    case invalidToken
    
    /// The response from the server is invalid.
    case invalidResponse
    
    /// The URL in the request is invalid.
    case invalidURL
    
    /// The status code received by the server in invalid.
    case invalidStatusCode
}

