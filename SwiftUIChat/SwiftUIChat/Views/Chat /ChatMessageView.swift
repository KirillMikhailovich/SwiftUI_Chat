//
//  ChatMessageView.swift
//  SwiftUIChat
//
//  Created by Kiryl Mikhailovich on 19.10.22.
//

import Foundation

import SwiftUI

struct ChatMessageView : View {

    private enum Constants {
        static let verticalSpacing: CGFloat = 15

        static let defaultUserId = "defaultUser"
    }

    var currentMessage: Message

    var body: some View {
        HStack(alignment: .bottom,
               spacing: Constants.verticalSpacing) {
            if currentMessage.user == Constants.defaultUserId {
                Spacer()
            }
            ContentMessageView(contentMessage: currentMessage.content,
                               isCurrentUser:currentMessage.user == Constants.defaultUserId )
            if currentMessage.user != Constants.defaultUserId {
                Spacer()
            }
        }
    }

}

struct ContentMessageView: View {

    private enum Constants {
        static let trailingMessageTextPadding: CGFloat = 20
        static let bottomMessageTextPadding: CGFloat = 30
        static let paddingDateText: CGFloat = 6

        static let cornerRadius: CGFloat = 10

        static let currentUserBackgrounColor = Color("user_message_background")
        static let interlocutorBackgrounColor = Color("interlocutor_message_background")
    }

    var contentMessage: String
    var isCurrentUser: Bool

    @State private var frame: CGSize = .zero

    var body: some View {
            Text(contentMessage)
            .padding([.leading, .top])
            .padding(.trailing, Constants.trailingMessageTextPadding)
            .padding(.bottom, Constants.bottomMessageTextPadding)
            .foregroundColor(Color.black)
            .font(.system(size: 14))
            .overlay() {
                HStack {
                    Spacer()

                    VStack {
                        Spacer()

                        Text("12:23")
                            .foregroundColor(Color.gray)
                            .font(.system(size: 12))
                            .padding([.horizontal, .vertical], Constants.paddingDateText)
                    }
                }
            }
            .background(isCurrentUser ? Constants.currentUserBackgrounColor : Constants.interlocutorBackgrounColor)
            .cornerRadius(Constants.cornerRadius)
    }
}

struct ChatMessageView_Previews: PreviewProvider {

    static var previews: some View {
        let message = Message(content: "test",
                              user: "defaultUer")
        ChatMessageView(currentMessage: message)
    }

}
