//
//  MessagesView.swift
//  SwiftUIChat
//
//  Created by Kiryl Mikhailovich on 20.10.22.
//

import SwiftUI

struct MessagesView: View {

    private enum Constants {
        static let horizontalPadding: CGFloat = 10
        static let commonUsersNegativeVerticalPadding: CGFloat = 15
        static let differentUsersNegativeVerticalPadding: CGFloat = 5
    }
    var messages: [Message] = Mock.messages

    var body: some View {
        GeometryReader { reader in
            ScrollView(.vertical) {
                ScrollViewReader { value in
                    VStack(spacing: 0) {
                        Spacer()

                        MessageOfferInfoView()
                            .padding(.horizontal, Constants.horizontalPadding)


                        ForEach(Array(messages.enumerated()), id: \.offset) { index, message in

                            ChatMessageView(currentMessage: message,
                                            isFirstMessage: isFirstMessage(index: index))
                            .id(message.id)
                            .padding(.bottom, isFirstMessage(index: index) ? -Constants.differentUsersNegativeVerticalPadding :  -Constants.commonUsersNegativeVerticalPadding)
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
                    .frame(minHeight: reader.size.height)
                }
            }
            .padding(.horizontal, Constants.horizontalPadding)
            .frame(maxWidth: .infinity)
        }
    }

    private func isFirstMessage(index: Int) -> Bool {
        var isFirstMessage = false
        if index != messages.count - 1 {
            isFirstMessage = messages[index].user != messages[messages.index(after: index)].user

        } else {
            isFirstMessage = true
        }

        return isFirstMessage
    }
}

struct MessagesView_Preview: PreviewProvider {

    static var previews: some View {
        MessagesView()
            .frame(width: .infinity)
    }
    
}
