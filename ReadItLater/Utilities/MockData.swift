//
//  MockData.swift
//  ReadItLater
//
//  Created by Mac on 15/07/26.
//

import Foundation

struct MockData {

    static let articles: [Article] = [

        Article(
            url: URL(string: "https://developer.apple.com")!,
            title: "Apple Developer"
        ),


        Article(
            url: URL(string: "https://www.swift.org")!,
            title: "Swift Programming Language",
            sessions: [
                ReadingSession(
                    duration: 420
                )
            ]
        ),


        Article(
            url: URL(string: "https://openai.com")!,
            title: "OpenAI",
            sessions: [
                ReadingSession(
                    duration: 1250
                )
            ]
        )

    ]

}
