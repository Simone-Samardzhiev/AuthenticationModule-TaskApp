//
//  DefaultAuthenticationManager.swift
//  AuthenticationModule
//
//  Created by Simone Samardzhiev on 20.11.24.
//

import Foundation
import Security

public actor DefaultAuthenticationManager: AuthenticationManager {
    public var decoder: JSONDecoder
    
    public var encoder: JSONEncoder
    
    /// Default initializer.
    /// - Parameters:
    ///   - decoder: The decoder that will be used to decode the data.
    ///   - encoder: The encoder that will be used to encode the data.
    public init(decoder: JSONDecoder, encoder: JSONEncoder) {
        self.decoder = decoder
        self.encoder = encoder
    }
    
    public func login(email: String, password: String) async throws -> String {
        // Construct the URL for the login endpoint, throws error if the URL is invalid
        guard let url = URL(string: "http://localhost:8080/users/login") else {
            throw AuthenticationError.invalidURL
        }
        
        // Encode user credentials into JSON
        let userData = try encoder.encode(User(email: email, password: password))
        
        // Prepare the HTTP request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = userData
        
        // Make the network request and await response
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Ensure we received an HTTP response, throw error if not
        guard let response = response as? HTTPURLResponse else {
            throw AuthenticationError.invalidResponse
        }
        
        // Handle different HTTP status codes
        switch response.statusCode {
        case 200:
            // Successfully authenticated - convert received data to token string
            guard let token = String(data: data, encoding: .utf8) else {
                throw AuthenticationError.invalidResponse
            }
            return token
        case 401:
            // Unauthorized - incorrect credentials
            throw AuthenticationError.invalidCredentials
        default:
            // Unexpected status code
            throw AuthenticationError.invalidStatusCode
        }
    }
    
    public func register(email: String, password: String, confirmPassword: String) async throws {
        // Check if both passwords match, throws error if they don't
        guard password == confirmPassword else {
            throw AuthenticationError.passwordMismatch
        }
        
        // Construct the URL for register endpoint, throws error if the URL is invalid
        guard let url = URL(string: "http://localhost:8080/users/register") else {
            throw AuthenticationError.invalidURL
        }
        
        // Encode user credentials into JSON
        let userData = try encoder.encode(User(email: email, password: password))
        
        // Prepare HTTP request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = userData
        
        // Make the network request and await response
        let (_, response) = try await URLSession.shared.data(for: request)
        
        // Ensure we received an HTTP response, throw error if not
        guard let response = response as? HTTPURLResponse else {
            throw AuthenticationError.invalidResponse
        }
        
        // Handle different HTTP status codes
        switch response.statusCode {
        case 200:
            // Successfully register
            return
        case 409:
            // Conflict - email is already in use
            throw AuthenticationError.emailInUse
        default:
            // Unexpected status code
            throw AuthenticationError.invalidStatusCode
        }
    }
    
    // Make the network request and await response
    public func refreshTokens(refreshToken: String) async throws -> TokenGroup {
        // Construct the URL for register endpoint, throws error if the URL is invalid
        guard let url = URL(string: "http://localhost:8080/refresh") else {
            throw AuthenticationError.invalidURL
        }
        
        // Prepare the HTTP request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(refreshToken)", forHTTPHeaderField: "Authorization")
        
        // Make the network request and await response
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Ensure we received an HTTP response, throw error if not
        guard let response = response as? HTTPURLResponse else {
            throw AuthenticationError.invalidResponse
        }
        
        switch response.statusCode {
        case 200:
            // Successfully refreshed - convert data to a token group
            return try decoder.decode(TokenGroup.self, from: data)
        case 401:
            // Unauthorized - invalid or expired token
            throw AuthenticationError.invalidToken
        default:
            // Unexpected status code
            throw AuthenticationError.invalidStatusCode
        }
    }
    
    public func saveToken(token: String) async -> Bool {
        // Transform the token into data
        guard let data = token.data(using: .utf8) else {
            return false
        }
        
        // Create the query
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "token",
            kSecValueData as String: data
        ]
        
        // Delete an existing token
        SecItemDelete(query as CFDictionary)
        
        // Add the token and check the status
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }
    
    public func getToken() async -> String? {
        // Creating the query
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "token",
            kSecReturnData as String: true
        ]
        
        // Getting the result
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        // Check the status
        guard status == errSecSuccess else {
            return nil
        }
        
        // Check the data
        guard let data = result as? Data else {
            return nil
        }
        
        // Transform the data into string
        return String(data: data, encoding: .utf8)
    }
}
