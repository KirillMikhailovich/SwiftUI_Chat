//
//  ContentView.swift
//  ChatView
//
//  Created by Kiryl Mikhailovich on 19.10.22.
//

import SwiftUI

struct ChatView: View {
    var body: some View {
        VStack() {
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

            ChatOfferDescriptionView()

            Divider()
                .background(Color.black)

            ScrollView {

            }

            Spacer()
        }
    }
}


struct ChatUserInfoView: View {
    var body: some View {
        HStack {
            Image("avatar")
                .resizable()
                .frame(width: 34, height: 34)

            VStack(alignment: .leading, spacing: 0) {
                    Text("Daniel Moriz")
                        .bold()
                        .font(.system(size: 14))

                    HStack(spacing: 6) {
                        ZStack {
                            Image(systemName: "checkmark.seal.fill")
                                .resizable()
                                .frame(width: 16, height: 16)
                        }
                        .frame(width: 16, height: 16)


                        Text("Verified")
                            .font(.system(size: 12))

                    }

                }
        }
    }
}

struct ChatOfferDescriptionView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text("Cleaning of a two-room apartment")
                    .underline()
                    .font(.system(size: 12))

                Text("€1 498,00")
                    .font(.system(size: 14))
                    .bold()
            }


            Spacer()

            ChatOfferButton(title: "Change offer") {
                print("Change offer")
            }
            .padding(.top, 6)
            .frame(width: 120)
        }
        .padding(.horizontal, 14)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
