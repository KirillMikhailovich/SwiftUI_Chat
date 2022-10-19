//
//  ChatUserInfoView.swift
//  SwiftUIChat
//
//  Created by Kiryl Mikhailovich on 19.10.22.
//

import SwiftUI

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

struct ChatUserInfoView_Previews: PreviewProvider {

    static var previews: some View {
        ChatUserInfoView()
    }

}


