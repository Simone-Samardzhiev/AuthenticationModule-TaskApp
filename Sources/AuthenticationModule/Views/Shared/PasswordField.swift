//
//  PasswordField.swift
//  AuthenticationModule
//
//  Created by Simone Samardzhiev on 4.12.24.
//

import SwiftUI


struct PasswordField: View {
    @Binding var text: String
    let message: String
    @State var show: Bool
    
    public init(text: Binding<String>, message: String) {
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
