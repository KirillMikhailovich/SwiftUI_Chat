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

    @Binding var isBlurActive: Bool
    @State var editMessadeIndex: Int = Int.min


    var messages: [Message] = Mock.messages

    var body: some View {
        ZStack {

            makeMessagesScroll()

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


    private func makeMessageView(message: Message, index: Int) -> some View {
        ChatMessageView(currentMessage: message,
                        isFirstMessage: isFirstMessage(index: index))
        .id(message.id)
        .padding(.bottom, isFirstMessage(index: index) ? -Constants.differentUsersNegativeVerticalPadding :  -Constants.commonUsersNegativeVerticalPadding)
        .blur(radius: isBlurActive && index != editMessadeIndex ? 5 : 0)
        .onTapGesture {
            withAnimation() {
                if editMessadeIndex != index {
                    isBlurActive = false
                }
            }
        }
        .gesture(
            LongPressGesture(minimumDuration: 0.5)
                .onEnded { value in
                    withAnimation {
                        editMessadeIndex = index
                        isBlurActive = true
                    }
                }
        )
    }

    private func makeMessagesScroll() -> some View {
        GeometryReader { reader in
            ScrollView(.vertical) {
                ScrollViewReader { value in
                    VStack(spacing: 0) {
                        Spacer()

                        MessageOfferInfoView()
                            .padding(.horizontal, Constants.horizontalPadding)
                            .addBlurLogic(isBlurActive: $isBlurActive)


                        ForEach(Array(messages.enumerated()), id: \.offset) { index, message in
                            makeMessageView(message: message,
                                            index: index)
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
                    .onTapGesture {
                        withAnimation() {
                            isBlurActive = false
                        }
                    }
                }
            }

            .padding(.horizontal, Constants.horizontalPadding)
            .frame(maxWidth: .infinity)
        }
    }
}

struct MessagesView_Preview: PreviewProvider {

    @State static var isBlurActive: Bool = false

    static var previews: some View {
        MessagesView(isBlurActive: $isBlurActive)
            .frame(width: .infinity)
    }
    
}
