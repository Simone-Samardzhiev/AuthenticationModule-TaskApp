//
//  LoginButton.swift
//  AuthenticationModule
//
//  Created by Simone Samardzhiev on 4.12.24.
//

import SwiftUI
import Utilities


/// Button used to log in.
struct LoginButton: View {
    @Environment(DefaultAuthenticationViewModel.self) var viewModel
    
    var body: some View {
        @Bindable var viewModel = viewModel
        
        ZStack {
            if viewModel.state.isIdle {
                Button("Login") {
                    Task {
                        await viewModel.login()
                    }
                }
                .modifier(ButtonModifier())
                .transition(.scale)
            } else {
                ProgressWidget($viewModel.state)
            }
        }
        .animation(.bouncy, value: viewModel.state)
    }
}
