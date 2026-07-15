//
//  ReadingSession.swift
//  ReadItLater
//
//  Created by Mac on 15/07/26.
//

import Foundation

struct ReadingSession: Identifiable, Codable, Hashable {

    let id: UUID

    let duration: TimeInterval

    let completedAt: Date

    init(
        id: UUID = UUID(),
        duration: TimeInterval,
        completedAt: Date = Date()
    ) {
        self.id = id
        self.duration = duration
        self.completedAt = completedAt
    }

}
