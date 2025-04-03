//
//  View.swift
//  News Application
//
//  Created by Luka Gujejiani on 03.04.25.
//

import SwiftUI

// MARK: - Shimmer Effect Modifier

extension View {
    func shimmering() -> some View {
        self.modifier(ShimmerEffect())
    }
}

struct ShimmerEffect: ViewModifier {
    @State private var phase: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .overlay(
                LinearGradient(
                    gradient: Gradient(colors: [
                        .clear,
                        .blue.opacity(0.6),
                        .clear
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .mask(content)
                .offset(x: phase)
                .animation(
                    .linear(duration: 1.5)
                    .repeatForever(autoreverses: false),
                    value: phase
                )
                .onAppear {
                    phase = UIScreen.main.bounds.width
                }
            )
    }
}
