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
        static let firstMessageOffset: CGFloat = 10

        static let defaultUserId = "defaultUser"
    }

    var currentMessage: Message
    var isFirstMessage: Bool
    var isCurrentUser: Bool {
        currentMessage.user == Constants.defaultUserId
    }

    var body: some View {
        HStack(alignment: .bottom,
               spacing: Constants.verticalSpacing) {
            if isCurrentUser {
                Spacer()
            }

            ContentMessageView(message: currentMessage,
                               isCurrentUser: isCurrentUser)

            .overlay() {
                Group {
                    if isFirstMessage {
                        VStack {
                            Spacer()

                            HStack() {

                                if isCurrentUser {
                                    Spacer()
                                }

                                Image(isCurrentUser ? "first_message_user" : "first_message_interlocutor" )

                                if !isCurrentUser {
                                    Spacer()
                                }
                            }
                            .offset(x: isCurrentUser ? Constants.firstMessageOffset : -Constants.firstMessageOffset )
                        }
                    } else {
                        EmptyView()
                    }
                }
            }
            .padding(Constants.firstMessageOffset)

            if !isCurrentUser {
                Spacer()
            }
        }
    }

}

struct ContentMessageView: View {

    private enum Constants {
        static let leadingMessageTextPadding: CGFloat = 10
        static let trailingMessageTextPadding: CGFloat = 40
        static let bottomMessageTextPadding: CGFloat = 30
        static let paddingDateText: CGFloat = 6
        static let statusInfoSpacing: CGFloat = 3

        static let cornerRadius: CGFloat = 10

        static let currentUserBackgrounColor = Color("user_message_background")
        static let interlocutorBackgrounColor = Color("interlocutor_message_background")
    }

    var message: Message
    var isCurrentUser: Bool
    var statusImage: Image {
        switch message.state {
        case .readed:
            return Image("double_checkmark")
        case .sended:
            return Image(systemName: "checkmark")
        }
    }

    @State private var frame: CGSize = .zero

    var body: some View {
        Text(message.content)
            .padding([.top, .leading])
            .padding(.trailing, Constants.trailingMessageTextPadding)
            .padding(.bottom, Constants.bottomMessageTextPadding)
            .foregroundColor(Color.black)
            .font(.system(size: 14))
            .overlay() {
                VStack {
                    Spacer()

                    HStack(spacing: Constants.statusInfoSpacing) {
                        Spacer()

                        Text("12:23")
                            .foregroundColor(Color.gray)
                            .font(.system(size: 12))


                        statusImage
                    }
                    .padding([.horizontal, .vertical], Constants.paddingDateText)
                }
            }


            .background(isCurrentUser ? Constants.currentUserBackgrounColor : Constants.interlocutorBackgrounColor)
            .cornerRadius(Constants.cornerRadius)
    }
}

struct ChatMessageInterlocutorView_Previews: PreviewProvider {

    static var previews: some View {
        let message = Message(content: "test",
                              user: "defaultUser")
        ChatMessageView(currentMessage: message,
                        isFirstMessage: true)
    }

}


struct ChatMessageUserView_Previews: PreviewProvider {

    static var previews: some View {
        let message = Message(content: "test",
                              user: "defaultUer")
        ChatMessageView(currentMessage: message,
                        isFirstMessage: true)
    }

}
