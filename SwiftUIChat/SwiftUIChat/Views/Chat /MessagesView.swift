//
//  MessagesView.swift
//  SwiftUIChat
//
//  Created by Kiryl Mikhailovich on 20.10.22.
//

import SwiftUI

struct MessagesView: View {
    
    var messages: [Message] = Mock.messages

    var body: some View {
        GeometryReader { reader in
            ScrollView(.vertical) {
                ScrollViewReader { value in
                    VStack() {
                        Spacer()

                        MessageOfferInfoView()


                        ForEach(messages) { message in
                            ChatMessageView(currentMessage: message)
                                .id(message.id)
                        }
                        .onAppear {
                            value.scrollTo(messages.last?.id,
                                           anchor: .bottomTrailing)
                        }

                        .frame(maxWidth: .infinity)
                        .edgesIgnoringSafeArea(.horizontal)
                        .listStyle(PlainListStyle())
                    }
                    .background(.white)
                    .padding()
                    .frame(minHeight: reader.size.height)
                }
            }
        }
    }
}

struct MessagesView_Preview: PreviewProvider {

    static var previews: some View {
        MessagesView()
            .frame(width: .infinity)
    }
    
}
