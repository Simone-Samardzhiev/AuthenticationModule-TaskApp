//
//  File.swift
//  AuthenticationModule
//
//  Created by Simone Samardzhiev on 2.12.24.
//

import Foundation
import Utilities


/// The default view model used to authenticate,
@Observable
@MainActor
public class DefaultAuthenticationViewModel: AuthenticationViewModel {
    @ObservationIgnored
    public var manager: AuthenticationManager
    
    public var state: ProgressState
    
    public var email: String
    
    public var password: String
    
    public var confirmPassword: String
    
    /// Default initializer.
    /// - Parameter manager: The manager used to manage all authentication requests.
    public init(manager: AuthenticationManager) {
        self.manager = manager
        self.state = .idle
        self.email = ""
        self.password = ""
        self.confirmPassword = ""
    }
    
    public func login() async {
        state = .loading("Logging in")
        do {
            let token = try await manager.login(email: email, password: password)
            if await !manager.saveToken(token: token) {
                state = .failure("Unknown error")
            }
        } catch let error as AuthenticationError {
            switch error {
            case .invalidCredentials:
                state = .failure("Wrong credentials!")
            default:
                state = .failure("Unknown error")
            }
        } catch {
            state = .failure("Unknown error")
        }
    }
    
    public func register() async {
        state = .loading("Registering")
        do {
            try await manager.register(email: email, password: password, confirmPassword: confirmPassword)
        } catch let error as AuthenticationError {
            switch error {
            case .passwordMismatch:
                state = .failure("The passwords doesn't match")
            case .emailInUse:
                state = .failure("The email is already in use")
            default:
                state = .failure("Unknown error")
            }
        } catch {
            state = .failure("Unknown error")
        }
    }
    
    public func resetCredentials() {
        self.state = .idle
        self.email = ""
        self.password = ""
        self.confirmPassword = ""
    }
}
