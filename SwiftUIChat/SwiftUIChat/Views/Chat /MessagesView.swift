//
//  MessagesView.swift
//  SwiftUIChat
//
//  Created by Kiryl Mikhailovich on 20.10.22.
//

import SwiftUI

struct MessagesView: View {
    var body: some View {
        GeometryReader { reader in
            ScrollView {
                VStack() {
                    Spacer()

                    MessageOfferInfoView()


                    ForEach(DataSource.messages) { message in
                        ChatMessageView(currentMessage: message)
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

struct MessagesView_Preview: PreviewProvider {
    static var previews: some View {
        MessagesView()
            .frame(width: .infinity)
    }
}
