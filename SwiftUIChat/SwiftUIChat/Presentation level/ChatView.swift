//
//  ContentView.swift
//  ChatView
//
//  Created by Kiryl Mikhailovich on 19.10.22.
//

import SwiftUI

struct ChatView: View {

    @State private var messageText: String = ""
    @State private var isBlurActive: Bool = false
    @State private var choosedMessageIndex: Int? = nil
    @State private var editFieldPosition: CGPoint = .zero

    @State private var headerHeight: CGFloat = 0
    @State private var footerHeight: CGFloat = 0

    @State private var choosedOption: EditOption? = nil
    @State private var editedMessage: Message? = nil

    private var adaptiveEditFieldPosition: CGPoint {
        var position: CGPoint = editFieldPosition
        position.y = editFieldPosition.y + headerHeight + messageEditOffset
        return position
    }

    private var messageEditOffset: CGFloat {
        let contentHeight = editFieldPosition.y + headerHeight + EditMessageView.height + footerHeight
        if contentHeight >
            UIScreen.main.bounds.size.height {
            let offset = UIScreen.main.bounds.size.height - contentHeight
            return offset
        }
        return 0
    }

    var body: some View {
        ZStack {
            makeChat()
            
            if isBlurActive {
                EditMessageView(choosedOption: $choosedOption)
                    .position(adaptiveEditFieldPosition)
            }
        }
        .onChange(of: choosedOption) { option in
            if let option = option {
                withAnimation() {
                    if let choosedMessageIndex = choosedMessageIndex,
                       option.title == "Edit" {
                        editedMessage = Mock.messages[choosedMessageIndex]
                    }

                    choosedOption = nil
                    choosedMessageIndex = nil
                    isBlurActive = false
                }
            }
        }
        .onChange(of: editedMessage) { message in
            if message == nil {
                choosedMessageIndex = nil
                isBlurActive = false
            }
        }
    }

    private func makeChat() -> some View {
        VStack(spacing: 0) {
            Group {
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

            }
            .overlay {
                GeometryReader { reader in
                    EmptyView()
                        .onChange(of: isBlurActive) { _ in
                            headerHeight = reader.size.height
                    }
                }
                
            }
            .addBlurLogic(isBlurActive: $isBlurActive)

            MessagesView(isBlurActive: $isBlurActive,
                         editFieldPosition: $editFieldPosition,
                         choosedMessageIndex: $choosedMessageIndex)
            .offset(y: messageEditOffset)


            Group {
                Divider()
                    .addBlurLogic(isBlurActive: $isBlurActive)

                ChatFooterView(title: "Message...",
                               text: $messageText,
                               editedMessage: $editedMessage)
                .addBlurLogic(isBlurActive: $isBlurActive)
                .padding(15)

            }
            .overlay {
                GeometryReader { reader in
                    EmptyView()
                        .onChange(of: isBlurActive) { _ in
                            footerHeight = reader.size.height
                    }
                }

            }
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
