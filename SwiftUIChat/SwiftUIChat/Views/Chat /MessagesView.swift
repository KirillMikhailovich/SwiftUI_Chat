//
//  MessagesView.swift
//  SwiftUIChat
//
//  Created by Kiryl Mikhailovich on 20.10.22.
//

import SwiftUI

struct MessagesView: View {

    private enum Constants {
        static let horizontalPadding: CGFloat = 12
        static let verticalEditViewPadding: CGFloat = 30
        static let commonUsersNegativeVerticalPadding: CGFloat = 15
        static let differentUsersNegativeVerticalPadding: CGFloat = 5

    }

    @Binding var isBlurActive: Bool
    @Binding var editFieldPosition: CGPoint
    @Binding var choosedMessageIndex: Int?


    var messages: [Message] = Mock.messages

    var body: some View {
        makeMessagesScroll()
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


    private func makeMessageView(message: Message,
                                 index: Int,
                                 gloabalReader: GeometryProxy) -> some View {
        ChatMessageView(currentMessage: message,
                        isFirstMessage: isFirstMessage(index: index))
        .id(message.id)
        .padding(.bottom, isFirstMessage(index: index) ? -Constants.differentUsersNegativeVerticalPadding :  -Constants.commonUsersNegativeVerticalPadding)
        .blur(radius: isBlurActive && index != choosedMessageIndex ? 5 : 0)
        .onTapGesture {
            withAnimation() {
                if choosedMessageIndex != index {
                    isBlurActive = false
                }
            }
        }
        .overlay {
            GeometryReader { cellReader in
                EmptyView()
                    .onChange(of: isBlurActive) { _ in
                        if choosedMessageIndex == index {

                            let xPosition = message.user == Mock.firstUser ?
                            cellReader.frame(in: .global).maxX - EditMessageView.width / 2 - Constants.horizontalPadding :
                            Constants.horizontalPadding * 2 + EditMessageView.width / 2
                            let yPosition = cellReader.frame(in: .global).maxY + Constants.verticalEditViewPadding

                            editFieldPosition = CGPoint(x: xPosition,
                                                             y: yPosition)
                        }
                    }
            }
        }
        .gesture(
            LongPressGesture(minimumDuration: 0.5)
                .onEnded { value in
                    withAnimation {
                        choosedMessageIndex = index
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
                                                index: index,
                                                gloabalReader: reader)
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
            .onChange(of: isBlurActive) { value in
                if !value {
                    withAnimation() {
                        choosedMessageIndex = Int.min
                        editFieldPosition = .zero
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
    @State static var editFieldPosition: CGPoint = .zero
    @State static var choosedMessageIndex: Int?

    static var previews: some View {
        MessagesView(isBlurActive: $isBlurActive,
                     editFieldPosition: $editFieldPosition,
                     choosedMessageIndex: $choosedMessageIndex)
            .frame(width: .infinity)
    }
    
}
