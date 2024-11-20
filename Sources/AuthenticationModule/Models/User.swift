//
//  User.swift
//  AuthenticationModule
//
//  Created by Simone Samardzhiev on 20.11.24.
//

import Foundation


/// Struct used to send user information to the server.
struct User: Encodable {
    /// The email of the user.
    let email: String
    
    /// The password of the user.
    let password: String
}
