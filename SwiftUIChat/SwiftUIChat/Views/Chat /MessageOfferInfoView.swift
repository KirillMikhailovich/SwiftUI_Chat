//
//  MessageOfferInfoView.swift
//  SwiftUIChat
//
//  Created by Kiryl Mikhailovich on 20.10.22.
//

import SwiftUI

struct MessageOfferInfoView: View {

    private enum Constants {
        static let verticalSpacing: CGFloat = 10
        static let stackPadding: CGFloat = 15
        static let cornerRadius: CGFloat = 10

        static let borderColor = Color("border_color")
    }

    var body: some View {
        VStack(spacing: Constants.verticalSpacing){
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
        .padding(Constants.stackPadding)
        .background(
            RoundedRectangle(
                cornerRadius: Constants.cornerRadius,
                style: .continuous
            )
            .stroke(Constants.borderColor)
        )
    }
}

struct MessageOfferInfoView_Preview: PreviewProvider {

    static var previews: some View {
        MessageOfferInfoView()
            .frame(width: .infinity)
    }
    
}
