//
//  BlurProvider.swift
//  SwiftUIChat
//
//  Created by Kiryl Mikhailovich on 21.10.22.
//

import SwiftUI

struct BlurProvider: ViewModifier {
    @Binding var isBlurActive: Bool

    func body(content: Content) -> some View {
        content
            .blur(radius: isBlurActive ? 5 : 0)
            .onTapGesture {
                withAnimation() {
                    isBlurActive = false
                }
            }
    }
}

extension View {
    func addBlurLogic(isBlurActive: Binding<Bool>) -> some View {
        modifier(BlurProvider(isBlurActive: isBlurActive))
    }
}
