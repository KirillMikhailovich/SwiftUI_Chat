//
//  ContentView.swift
//  ChatView
//
//  Created by Kiryl Mikhailovich on 19.10.22.
//

import SwiftUI

struct ChatView: View {

    @State private var messageText: String = ""

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 20) {
                Image(systemName: "chevron.left")
                    .resizable()
                    .frame(width: 9, height: 17)

                ChatUserInfoView()

                Spacer()

                Image(systemName: "ellipsis")

            }
            .padding(.horizontal, 20)
            .padding(.vertical, 14)

            Divider()
                .background(Color.black)
                .padding(.vertical, 14)

            ChatOfferInfoView()

            Divider()
                .background(Color.black)
                .padding(.top, 14)
            
            MessagesView()

            Divider()

            ChatInputTextField(title: "Message...",
                               text: $messageText)
            .padding(15)




        }
        .background(.white)
    }
}


struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
