//
//  EmailField.swift
//  AuthenticationModule
//
//  Created by Simone Samardzhiev on 4.12.24.
//

import SwiftUI


/// Field used to enter the email.
struct EmailField: View {
    /// The email that will be edited.
    @Binding var text: String
    
    /// Default initializer.
    /// - Parameter text: The text that will be edited.
    init(_ text: Binding<String>) {
        self._text = text
    }
    
    var body: some View {
        VStack(spacing: 0) {
            TextField("Email", text: $text)
            Rectangle()
                .frame(height: 1)
        }
    }
}
