//
//  ChatOfferInfoView.swift
//  SwiftUIChat
//
//  Created by Kiryl Mikhailovich on 19.10.22.
//

import SwiftUI

struct ChatOfferInfoView: View {
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

struct ChatOfferInfoView_Previews: PreviewProvider {

    static var previews: some View {
        ChatOfferInfoView()
    }

}
