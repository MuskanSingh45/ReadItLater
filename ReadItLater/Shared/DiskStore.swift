//
//  DiskStore.swift
//  ReadItLater
//
//  Created by Mac on 15/07/26.
//

import Foundation

final class DiskStore {

    private let fileName = "articles.json"

    private let appGroup =
    "group.com.amansingh.ReadItLater"

    private var fileURL: URL {

        guard let url =
        FileManager.default.containerURL(
            forSecurityApplicationGroupIdentifier: appGroup
        ) else {

            fatalError("App Group not found")
        }

        return url.appendingPathComponent(fileName)
    }

    func save(_ articles: [Article]) throws {

        let data = try JSONEncoder().encode(articles)

        try data.write(to: fileURL)

    }

    func load() throws -> [Article] {

        guard FileManager.default.fileExists(
            atPath: fileURL.path
        ) else {

            return []

        }

        let data = try Data(contentsOf: fileURL)

        return try JSONDecoder().decode(
            [Article].self,
            from: data
        )

    }
}
