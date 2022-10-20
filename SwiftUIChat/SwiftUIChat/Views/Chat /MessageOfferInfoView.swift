//
//  MessageOfferInfoView.swift
//  SwiftUIChat
//
//  Created by Kiryl Mikhailovich on 20.10.22.
//

import SwiftUI

struct MessageOfferInfoView: View {
    var body: some View {
        VStack(spacing: 10){
            Image("offer_accepted")

            Text("Daniel gets your offer for")
                .font(.system(size: 14))

            Text("€1 498,00")
                .font(.system(size: 18, weight: .bold))

            Divider()

            Text("To complete the deal, Daniel must accept your offer, until that you can discuss the details here")
                .multilineTextAlignment(.center)
                .font(.system(size: 12))
        }
        .padding(15)
        .background(
            RoundedRectangle(
                cornerRadius: 10,
                style: .continuous
            )
            .stroke(Color("border_color"))
        )
    }
}

struct MessageOfferInfoView_Preview: PreviewProvider {
    static var previews: some View {
        MessageOfferInfoView()
            .frame(width: .infinity)
    }
}
