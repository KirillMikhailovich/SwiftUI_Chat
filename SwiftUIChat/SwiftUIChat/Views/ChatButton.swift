//
//  ChatButton.swift
//  SwiftUIChat
//
//  Created by Kiryl Mikhailovich on 19.10.22.
//

import SwiftUI

struct ChatOfferButton: View {

    private let title: String
    private let action: () -> Void

    @Environment(\.isEnabled) var isEnabled

    var body: some View {
        HStack {
            Button(action: self.action) {
                Text(title)
            }
            .buttonStyle(
                ChatButtonStyle()
            )
        }
        .frame(maxWidth: .infinity)
    }

    init(
        title: String,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.action = action
    }

}

struct ChatButtonStyle: ButtonStyle {

    private enum Constants {
        static let cornerRadius: CGFloat = 18
        static let verticalPadding: CGFloat = 10
        static let horizontalPadding: CGFloat = 16
    }

    init() {
    }

    func makeBody(configuration: Self.Configuration) -> some View {
        return configuration.label
            .background(.white)
            .cornerRadius(Constants.cornerRadius)
            .padding(.vertical, Constants.verticalPadding)
            .padding(.horizontal, Constants.horizontalPadding)
            .tint(.black)
            .font(Font.system(size: 14, weight: .bold))
            .minimumScaleFactor(0.7)
            .lineLimit(1)
            .background(
                RoundedRectangle(
                    cornerRadius: Constants.cornerRadius,
                    style: .continuous
                )
                .stroke(Color.black)
            )
    }
}


struct ChatOfferButton_Previews: PreviewProvider {

    static var previews: some View {
        ChatOfferButton(
            title: "Some title for testing",
            action: {}
        )
        .previewLayout(.sizeThatFits)
    }

}
