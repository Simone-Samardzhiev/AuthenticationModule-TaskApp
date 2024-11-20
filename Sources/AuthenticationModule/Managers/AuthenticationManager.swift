//
//  AuthenticationManager.swift
//  AuthenticationModule
//
//  Created by Simone Samardzhiev on 20.11.24.
//

import Foundation


/// Protocol used to create authentication manager that will manage all user authentication processes.
public protocol AuthenticationManager: Actor {
    /// The json decoder.
    var decoder: JSONDecoder { get }

    /// The json encoder.
    var encoder: JSONEncoder { get }
    
    /// Method that will send a request to the server, so the user can log in.
    /// - Parameters:
    ///   - email: The email of the user.
    ///   - password: The password of the user.
    /// - Throws: ``AuthenticationError``
    func login(email: String, password: String) async throws
    
    /// Method that will send the request to the server, so the user can register.
    /// - Parameters:
    ///   - email: The email of the user.
    ///   - password: The password of the user.
    ///   - confirmPassword: The confirm password of the user.
    /// - Throws:``AuthenticationError``
    func register(email: String, password: String, confirmPassword: String) async throws
    
    /// Method that will refresh the tokens by sending the refresh token.
    ///  - Warning: The token that was send will no longer be valid.
    /// - Parameter refreshToken: The refresh token that will be send.
    /// - Throws: ``AuthenticationError``
    /// - Returns: The token group send by the server.
    func refreshTokens(refreshToken: String) async throws -> TokenGroup
    
    /// Method that will save the token securely with a specific.
    /// - Parameters:
    ///   - token: The token that will be saved.
    ///   - key: The key to which the token belongs to.
    /// - Returns: True if the token was saved successfully.
    func saveToken(token: String, key: String) async -> Bool
    
    
    /// Method that will retrieve a token with a specific key.
    /// - Parameter key: The token or nil if the it was not found.
    func getToken(key: String) async -> String?
}
