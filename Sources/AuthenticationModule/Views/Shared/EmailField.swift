//
//  EmailField.swift
//  AuthenticationModule
//
//  Created by Simone Samardzhiev on 4.12.24.
//

import SwiftUI


struct EmailField: View {
    @Binding var text: String
    
    public init(_ text: Binding<String>) {
        self._text = text
    }
    
    var body: some View {
        VStack {
            TextField("Email", text: $text)
            Rectangle()
                .frame(height: 1)
        }
    }
}
