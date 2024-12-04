//
//  LoginView.swift
//  AuthenticationModule
//
//  Created by Simone Samardzhiev on 20.11.24.
//

import SwiftUI

/// View used by the user to log in.
public struct LoginView: View {
    @State var viewModel: DefaultAuthenticationViewModel
    
    /// Default initializer.
    public init(viewModel: DefaultAuthenticationViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        @Bindable var viewModel = viewModel
        NavigationStack {
            VStack {
                EmailField($viewModel.email)
            }
            .padding(.horizontal, 35)
            .navigationTitle("Login")
        }
    }
}

#Preview {
    LoginView(viewModel: DefaultAuthenticationViewModel(manager: DefaultAuthenticationManager(decoder: JSONDecoder(), encoder: JSONEncoder())))
}
