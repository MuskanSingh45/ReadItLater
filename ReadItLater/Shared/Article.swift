//
//  Article.swift
//  ReadItLater
//
//  Created by Mac on 14/07/26.
//

import Foundation

struct Article: Identifiable, Codable {

    let id: UUID

    let url: URL

    var title: String

    var sessions: [ReadingSession]

    var lastUpdated: Date


    // Derived value, not stored
    var totalReadingTime: TimeInterval {

        sessions.reduce(0) { total, session in
            total + session.duration
        }

    }


    init(
        id: UUID = UUID(),
        url: URL,
        title: String,
        sessions: [ReadingSession] = [],
        lastUpdated: Date = Date()
    ) {

        self.id = id
        self.url = url
        self.title = title
        self.sessions = sessions
        self.lastUpdated = lastUpdated

    }


    enum CodingKeys: String, CodingKey {

        case id
        case url
        case title
        case sessions
        case lastUpdated
        case totalReadingTime

    }


    // MARK: - Decode (supports old JSON)

    init(from decoder: Decoder) throws {

        let container = try decoder.container(
            keyedBy: CodingKeys.self
        )


        id = try container.decode(
            UUID.self,
            forKey: .id
        )


        url = try container.decode(
            URL.self,
            forKey: .url
        )


        title = try container.decode(
            String.self,
            forKey: .title
        )


        let decodedSessions = try container.decodeIfPresent(
            [ReadingSession].self,
            forKey: .sessions
        )


        if let decodedSessions {

            sessions = decodedSessions

        } else {

            let oldTotal = try container.decodeIfPresent(
                TimeInterval.self,
                forKey: .totalReadingTime
            ) ?? 0


            if oldTotal > 0 {

                sessions = [
                    ReadingSession(
                        duration: oldTotal
                    )
                ]

            } else {

                sessions = []

            }

        }


        lastUpdated = try container.decode(
            Date.self,
            forKey: .lastUpdated
        )

    }


    // MARK: - Encode (new JSON format)

    func encode(to encoder: Encoder) throws {

        var container = encoder.container(
            keyedBy: CodingKeys.self
        )


        try container.encode(
            id,
            forKey: .id
        )


        try container.encode(
            url,
            forKey: .url
        )


        try container.encode(
            title,
            forKey: .title
        )


        try container.encode(
            sessions,
            forKey: .sessions
        )


        try container.encode(
            lastUpdated,
            forKey: .lastUpdated
        )

    }

}
