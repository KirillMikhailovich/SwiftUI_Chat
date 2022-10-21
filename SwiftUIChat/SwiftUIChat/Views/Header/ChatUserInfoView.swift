//
//  ChatUserInfoView.swift
//  SwiftUIChat
//
//  Created by Kiryl Mikhailovich on 19.10.22.
//

import SwiftUI

struct ChatUserInfoView: View {

    private enum Constants {
        static let avatarSize: CGFloat = 34
        static let checkmarkSize: CGFloat = 16

        static let horizontalSpacing: CGFloat = 6
    }

    var body: some View {

        HStack {
            Image("avatar")
                .resizable()
                .frame(width: Constants.avatarSize,
                       height:  Constants.avatarSize)

            VStack(alignment: .leading,
                   spacing: 0) {
                Text("Daniel Moriz")
                    .bold()
                    .font(.system(size: 14))

                HStack(spacing: Constants.horizontalSpacing) {
                    ZStack {
                        Image(systemName: "checkmark.seal.fill")
                            .resizable()
                            .frame(width: Constants.checkmarkSize,
                                   height: Constants.checkmarkSize)
                    }
                    .frame(width: Constants.checkmarkSize,
                           height: Constants.checkmarkSize)


                    Text("Verified")
                        .font(.system(size: 12))

                }

            }
        }
    }
    
}

struct ChatUserInfoView_Previews: PreviewProvider {

    static var previews: some View {
        ChatUserInfoView()
    }

}


