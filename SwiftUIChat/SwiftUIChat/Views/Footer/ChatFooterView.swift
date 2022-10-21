//
//  ChatFooterView.swift
//  SwiftUIChat
//
//  Created by Kiryl Mikhailovich on 21.10.22.
//

import SwiftUI

struct ChatFooterView: View, KeyboardReadable{

    private enum Constants {
        static let horizontalPadding: CGFloat = 15
        static let verticalPadding: CGFloat = 5

        static let buttonSize: CGFloat = 40
    }

    @State private var isKeyboardVisible = false

    let title: String
    @Binding var text: String
    @Binding var editedMessage: Message?

    var body: some View {

        VStack {
            if editedMessage != nil {
                EditChatFooterView(editedMessage: $editedMessage)
                    .onTapGesture {
                        editedMessage = nil
                    }
            }

            HStack {

                ChatInputTextField(title: title,
                                   text: $text)
                    .previewLayout(.sizeThatFits)

                if isKeyboardVisible {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: Constants.buttonSize,
                               height: Constants.buttonSize)
                        .onTapGesture {
                            editedMessage = nil
                            UIApplication.shared.endEditing()
                        }
                }
            }
        }
        .onChange(of: editedMessage) { message in
            if let message = message {
                text = message.content
            } else {
                text = ""
            }
        }
        .onReceive(keyboardPublisher) { shown in
            isKeyboardVisible = shown
        }


    }
}

struct EditChatFooterView: View {
    private enum Constants {
        static let horizontalPadding: CGFloat = 15
        static let verticalPadding: CGFloat = 5
    }

    @Binding var editedMessage: Message?

    var body: some View {

        HStack(alignment: .top){
            VStack(spacing: Constants.verticalPadding) {
                HStack {
                    Image(systemName: "pencil")

                    Text("Edit message")
                        .font(.system(size: 12))

                    Spacer()
                }
                .foregroundColor(.gray)


                Text(editedMessage?.content ?? "")
                    .font(.system(size: 12))
                    .lineLimit(1)

            }

            Image(systemName: "xmark.circle.fill")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(Color("border_color"))
                .padding(.leading, Constants.horizontalPadding)
                .padding(.trailing, 3)
        }


    }
}

struct ChatFooterView_Previews: PreviewProvider {

    @State static var text: String = "test"
    @State static var editedMessage: Message? = Mock.messages.first

    static var previews: some View {
        ChatFooterView(title: "TestTitle",
                       text: $text,
                       editedMessage: $editedMessage)
            .previewLayout(.sizeThatFits)
    }

}
