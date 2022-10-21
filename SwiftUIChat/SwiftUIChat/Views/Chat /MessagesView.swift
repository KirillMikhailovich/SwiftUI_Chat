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
        static let verticalEditViewPadding: CGFloat = 14
        static let commonUsersNegativeVerticalPadding: CGFloat = 15
        static let differentUsersNegativeVerticalPadding: CGFloat = 5

    }

    @Binding var isBlurActive: Bool
    @Binding var editMessageBottomPoint: CGPoint
    @State private var editMessadeIndex: Int = Int.min


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
        .blur(radius: isBlurActive && index != editMessadeIndex ? 5 : 0)
        .onTapGesture {
            withAnimation() {
                if editMessadeIndex != index {
                    isBlurActive = false
                }
            }
        }
        .overlay {
            GeometryReader { cellReader in
                EmptyView()
                    .onChange(of: isBlurActive) { _ in
                        if editMessadeIndex == index {

                            let xPosition = message.user == Mock.firstUser ?
                            cellReader.frame(in: .global).maxX - EditMessageView.width / 2 - Constants.horizontalPadding :
                            Constants.horizontalPadding * 2 + EditMessageView.width / 2
                            let yPosition = cellReader.frame(in: .global).maxY + Constants.verticalEditViewPadding

                            editMessageBottomPoint = CGPoint(x: xPosition,
                                                             y: yPosition)
                        }
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
                        editMessadeIndex = Int.min
                        editMessageBottomPoint = .zero
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
    @State static var editMessageBottomPoint: CGPoint = .zero

    static var previews: some View {
        MessagesView(isBlurActive: $isBlurActive,
                     editMessageBottomPoint: $editMessageBottomPoint)
            .frame(width: .infinity)
    }
    
}
