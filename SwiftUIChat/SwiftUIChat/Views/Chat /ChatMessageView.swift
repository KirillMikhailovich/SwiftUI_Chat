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
        static let defaultUserId = "defaultUser"
    }

    var currentMessage: Message

    var body: some View {
        HStack(alignment: .bottom, spacing: 15) {
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
    var contentMessage: String
    var isCurrentUser: Bool

    @State private var frame: CGSize = .zero

    var body: some View {
            Text(contentMessage)
            .padding([.leading, .top])
            .padding(.trailing, 20)
            .padding(.bottom, 30)
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
                            .padding([.horizontal, .vertical], 6)
                    }
                }
            }
            .background(isCurrentUser ? Color("current_user_message_background") : Color("other_user_message_background"))
            .cornerRadius(10)
    }
}

struct ChatMessageView_Previews: PreviewProvider {
    static var previews: some View {
        let message = Message(content: "dsdsds", user: "defaultUer")
        ChatMessageView(currentMessage: message)
    }
}
