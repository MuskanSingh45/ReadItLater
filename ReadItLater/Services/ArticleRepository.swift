//
//  ArticleRepository.swift
//  ReadItLater
//
//  Created by Mac on 15/07/26.
//

import Foundation
import Observation


@Observable
final class ArticleRepository {


    private let memoryStore: MemoryStore

    private let diskStore: DiskStore

    private let mergeEngine = MergeEngine()


    private(set) var debugInfo = DebugInfo(
        memoryArticles: 0,
        diskArticles: 0,
        mergeReason: .identical,
        lastMerge: Date()
    )



    init(
        diskStore: DiskStore = DiskStore()
    ) {

        self.diskStore = diskStore


        do {

            let diskArticles = try diskStore.load()

            let memoryArticles = MockData.articles


            let mergeResult = mergeEngine.merge(
                memory: memoryArticles,
                disk: diskArticles
            )


            debugInfo = DebugInfo(
                memoryArticles: memoryArticles.count,
                diskArticles: diskArticles.count,
                mergeReason: mergeResult.reason,
                lastMerge: Date()
            )


            print(
                "Merge Result: \(mergeResult.reason.rawValue)"
            )


            self.memoryStore = MemoryStore(
                articles: mergeResult.articles
            )


        } catch {


            print(
                "Failed to load disk articles: \(error)"
            )


            let fallbackArticles = MockData.articles


            self.memoryStore = MemoryStore(
                articles: fallbackArticles
            )


            debugInfo = DebugInfo(
                memoryArticles: fallbackArticles.count,
                diskArticles: 0,
                mergeReason: .recoveredAfterCrash,
                lastMerge: Date()
            )

        }

    }



    var articles: [Article] {

        memoryStore.load()

    }



    func article(
        with id: UUID
    ) -> Article? {

        articles.first {
            $0.id == id
        }

    }



    func addReadingTime(
        _ elapsed: TimeInterval,
        to articleID: UUID
    ) {


        var articles = memoryStore.load()


        guard let index = articles.firstIndex(where: {
            $0.id == articleID
        }) else {

            return

        }


        let session = ReadingSession(
            duration: elapsed
        )


        articles[index].sessions.append(
            session
        )


        articles[index].lastUpdated = Date()



        // Save memory

        memoryStore.save(
            articles
        )



        // Save disk

        do {

            try diskStore.save(
                articles
            )

        } catch {

            print(
                "Failed to save articles: \(error)"
            )

        }

    }



    // Reload data from disk into memory

    func reload() {

        do {

            let diskArticles = try diskStore.load()

            memoryStore.save(
                diskArticles
            )


            debugInfo = DebugInfo(
                memoryArticles: diskArticles.count,
                diskArticles: diskArticles.count,
                mergeReason: .diskNewer,
                lastMerge: Date()
            )


        } catch {

            print(
                "Reload failed:",
                error
            )

        }

    }

}
