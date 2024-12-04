//
//  ButtonModifier.swift
//  AuthenticationModule
//
//  Created by Simone Samardzhiev on 4.12.24.
//

import SwiftUI

/// Modifier applied to buttons.
struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundStyle(Color.black)
            .padding()
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
