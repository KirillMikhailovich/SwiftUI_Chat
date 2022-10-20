//
//  ChatInputField.swift
//  SwiftUIChat
//
//  Created by Kiryl Mikhailovich on 20.10.22.
//

import SwiftUI

struct ChatInputTextField: View {

    enum Constants {
        static let height: CGFloat = 40
        static let textPadding: CGFloat = 10
        static let cornerRadius: CGFloat = 20
        static let extraTrailingTextPadding: CGFloat = 30

        static let backgroundColor = Color("interlocutor_message_background")

        static let galleryIconTrailingPadding: CGFloat = 15

    }

    let title: String
    @Binding var text: String

    var body: some View {
        HStack {
            TextField(title, text: $text, axis: .vertical)
                .textFieldStyle(.plain)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, Constants.textPadding)
                .font(.system(size: 14))
                .lineLimit(1...3)
                .background(.clear)
                .textFieldStyle(.roundedBorder)
                .padding(.trailing, Constants.extraTrailingTextPadding)
        }
        .padding(Constants.textPadding)
        .background(
            RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous)
                .fill(Constants.backgroundColor)
        )

        .overlay() {
            VStack() {
                Spacer()
                HStack() {
                    Spacer()

                    Image(systemName: "camera")
                        .padding(.bottom, Constants.textPadding)
                        .padding(.trailing, Constants.galleryIconTrailingPadding)
                }
            }
        }

    }
}

struct ChatInputTextField_Previews: PreviewProvider {
    
    @State static var text: String = "test"

    static var previews: some View {
        ChatInputTextField(title: "TestTitle", text: $text)
            .previewLayout(.sizeThatFits)
    }

}
