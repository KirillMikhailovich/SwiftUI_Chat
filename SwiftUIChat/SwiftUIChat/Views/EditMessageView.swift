//
//  EditMessageView.swift
//  SwiftUIChat
//
//  Created by Kiryl Mikhailovich on 21.10.22.
//

import SwiftUI

struct EditOption: Hashable {
    let title: String
    let icon: Image
    let color: Color

    init(title: String, icon: Image, color: Color = .black) {
        self.title = title
        self.icon = icon
        self.color = color
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}

struct EditMessageView: View {

    private static var editOptions: [EditOption] = [
        EditOption(title: "Save as template",
                   icon: Image(systemName: "text.badge.plus")),
        EditOption(title: "Copy",
                   icon:  Image(systemName:"square.on.square")),
        EditOption(title: "Edit", icon: Image(systemName:"pencil")),
        EditOption(title: "Delete",
                   icon: Image(systemName:"trash"),
                   color: .red)
    ]

    @Binding var choosedOption: EditOption?

    private enum Constants {
        static let cornerRadius: CGFloat = 10

        static let borderColor = Color("border_color")
        
    }

    static var height: CGFloat {
        CGFloat(editOptions.count) * EditMessageComponentView.Constants.height
    }

    static var width: CGFloat {
        CGFloat(EditMessageComponentView.Constants.width)
    }

    var body: some View {
        VStack(spacing: 0) {
            ForEach(EditMessageView.editOptions, id: \.self) { option in
                EditMessageComponentView(option: option)
                    .onTapGesture {
                        choosedOption = option
                    }
            }
        }
        .background(
            RoundedRectangle(
                cornerRadius: Constants.cornerRadius,
                style: .continuous
            )
            .stroke(Constants.borderColor)
            .background(
                RoundedRectangle(
                    cornerRadius: Constants.cornerRadius,
                    style: .continuous
                )
                .fill(.background)
            )
        )
    }
}

struct EditMessageComponentView: View {

    enum Constants {
        static let height: CGFloat = 40
        static let width: CGFloat = 200
        static let horizontalPadding: CGFloat = 14
        static let verticalPadding: CGFloat = 10
    }

    var option: EditOption

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(option.title)
                    .font(.system(size: 12))

                Spacer()

                option.icon

            }
            .contentShape(Rectangle())
            .padding(.horizontal, Constants.horizontalPadding)
            .padding(.vertical, 10)

            if option.title != "Delete" {
                Divider()
            }
        }
        .foregroundColor(option.color)
        .frame(width: Constants.width,
               height: Constants.height)
    }
}


struct EditMessageView_Previews: PreviewProvider {

    @State static var choosedOption: EditOption? = nil
    
    static var previews: some View {
        EditMessageView(choosedOption: $choosedOption)
    }

}
