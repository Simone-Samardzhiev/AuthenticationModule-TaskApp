//
//  PasswordField.swift
//  AuthenticationModule
//
//  Created by Simone Samardzhiev on 4.12.24.
//

import SwiftUI


/// Field used to enter the password.
struct PasswordField: View {
    /// The password that will be entered.
    @Binding var text: String
    
    /// The message that will be displayed.
    let message: String
    
    /// Variable used to show and hide the password.
    @State var show: Bool
    
    /// Default initializer.
    /// - Parameters:
    ///   - text: The password that will be changed.
    ///   - message: The message that will displayed.
    init(text: Binding<String>, message: String) {
        self._text = text
        self.message = message
        self.show = false
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                if show {
                    TextField(message, text: $text)
                } else {
                    SecureField(message, text: $text)
                }
                
                Button {
                    show.toggle()
                } label: {
                    Image(systemName: show ? "eye.slash.fill" : "eye.fill")
                }
                .animation(.easeInOut, value: show)
                
            }
            
            Rectangle()
                .frame(height: 1)
        }
    }
}
