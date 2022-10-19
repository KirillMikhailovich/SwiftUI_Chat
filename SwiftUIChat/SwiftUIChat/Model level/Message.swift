//
//  Message.swift
//  SwiftUIChat
//
//  Created by Kiryl Mikhailovich on 20.10.22.
//

import Foundation

struct Message: Hashable, Identifiable {
    var id = UUID()

    var content: String
    var user: String
}

struct DataSource {
    static let firstUser = "defaultUser"
    static var secondUser = "secondUser"
    static let messages = [
        Message(content: "Hi Daniel, my name is Eleni, I am a professional cleaner with 10 years of expirience. I can come to you tomorrow morning. 2 bedroom appartement costs 30 euros and takes about 3 hours. Is it okay for you?", user: DataSource.firstUser),
        Message(content: "I can also wash terrace, windows and balcony for extra 20 euros if needed. ", user: DataSource.firstUser),
        Message(content: "Hi Eleni, sounds good for me, tomorrow morning is perfect.", user: DataSource.secondUser),
        Message(content: "My plans have changed, so I’v changed the terms of order, could you reduce the cost please?", user: DataSource.secondUser),
    ]
}
