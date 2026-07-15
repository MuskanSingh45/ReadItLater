//
//  MergeEngine.swift
//  ReadItLater
//
//  Created by Mac on 15/07/26.
//

import Foundation


enum MergeReason: String {

    case identical = "Memory and disk were identical"

    case mergedUniqueSessions = "Merged unique reading sessions"

    case memoryNewer = "Memory contained newer article metadata"

    case diskNewer = "Disk contained newer article metadata"

    case recoveredAfterCrash = "Recovered unsaved session"

}



struct MergeResult {

    let articles: [Article]

    let reason: MergeReason

}



struct MergeEngine {


    func merge(
        memory: [Article],
        disk: [Article]
    ) -> MergeResult {


        var mergedArticles: [Article] = []

        var finalReason: MergeReason = .identical


        let allIDs = Set(
            memory.map(\.id) +
            disk.map(\.id)
        )


        for id in allIDs {


            let memoryArticle = memory.first {
                $0.id == id
            }


            let diskArticle = disk.first {
                $0.id == id
            }



            switch (memoryArticle, diskArticle) {


            case let (.some(memory), .some(disk)):


                let result = mergeArticle(
                    memory: memory,
                    disk: disk
                )


                mergedArticles.append(result.article)

                finalReason = result.reason



            case let (.some(memory), nil):


                mergedArticles.append(memory)

                finalReason = .memoryNewer



            case let (nil, .some(disk)):


                mergedArticles.append(disk)

                finalReason = .diskNewer



            default:

                break

            }

        }


        return MergeResult(
            articles: mergedArticles,
            reason: finalReason
        )

    }



    private func mergeArticle(
        memory: Article,
        disk: Article
    ) -> (
        article: Article,
        reason: MergeReason
    ) {


        let mergedSessions = Array(
            Set(
                memory.sessions +
                disk.sessions
            )
        )
        .sorted {
            $0.completedAt < $1.completedAt
        }



        var mergedArticle = memory


        mergedArticle.sessions = mergedSessions


        mergedArticle.lastUpdated = max(
            memory.lastUpdated,
            disk.lastUpdated
        )



        let reason: MergeReason


        if mergedSessions.count >
            max(
                memory.sessions.count,
                disk.sessions.count
            ) {


            reason = .mergedUniqueSessions



        } else if memory.lastUpdated > disk.lastUpdated {


            reason = .memoryNewer



        } else if disk.lastUpdated > memory.lastUpdated {


            reason = .diskNewer



        } else {


            reason = .identical

        }



        return (
            mergedArticle,
            reason
        )

    }

}
