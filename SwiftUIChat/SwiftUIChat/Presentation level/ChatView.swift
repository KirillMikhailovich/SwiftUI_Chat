//
//  ContentView.swift
//  ChatView
//
//  Created by Kiryl Mikhailovich on 19.10.22.
//

import SwiftUI

struct ChatView: View {

    @State private var messageText: String = ""
    @State var isBlurActive: Bool = false

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
            .addBlurLogic(isBlurActive: $isBlurActive)

            Divider()
                .background(Color.black)
                .padding(.vertical, 14)
                .addBlurLogic(isBlurActive: $isBlurActive)

            ChatOfferInfoView()
                .addBlurLogic(isBlurActive: $isBlurActive)


            Divider()
                .background(Color.black)
                .padding(.top, 14)
                .addBlurLogic(isBlurActive: $isBlurActive)
            
            MessagesView(isBlurActive: $isBlurActive)

            Divider()
                .addBlurLogic(isBlurActive: $isBlurActive)

            ChatInputTextField(title: "Message...",
                               text: $messageText)
            .addBlurLogic(isBlurActive: $isBlurActive)
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
