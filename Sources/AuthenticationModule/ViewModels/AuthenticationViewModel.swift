//
//  File.swift
//  AuthenticationModule
//
//  Created by Simone Samardzhiev on 2.12.24.
//

import Foundation
import Utilities


/// Protocol used to create a view model that will update the view when the user authenticate.
public protocol AuthenticationViewModel: Observable {
    /// Manager used to manage all authentication operations.
    var manager: AuthenticationManager { get }
    
    /// Variable holding the state of the current progress of an operation.
    var state: ProgressState { get }
    
    /// Variable holding the entered email.
    var email: String { get }
    
    /// Variable holding the entered password.
    var password: String { get }
    
    /// Variable holding the entered confirm password.
    var confirmPassword: String { get }
    
    /// Method that send a request to login the user.
    func login() async
    
    /// Method that will send a request to the register method.
    func register() async
    
    /// Method that will reset the variable credentials.
    func resetCredentials()
}
