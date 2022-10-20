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
    }

    let title: String
    @Binding var text: String

    var body: some View {
        HStack {
            TextField(title, text: $text, axis: .vertical)
                .textFieldStyle(.plain)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 10)
                .font(.system(size: 14))
                .lineLimit(1...3)
                .background(Color("other_user_message_background"))
                .textFieldStyle(.roundedBorder)
                .padding(.trailing, 30)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous)
                .fill(Color("other_user_message_background"))
        )

        .overlay() {
            VStack() {
                Spacer()
                HStack() {
                    Spacer()

                    Image(systemName: "camera")
                        .padding(.bottom, 12)
                        .padding(.trailing, 15)
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
