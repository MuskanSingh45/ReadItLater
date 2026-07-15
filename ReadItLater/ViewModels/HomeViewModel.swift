//
//  HomeViewModel.swift
//  ReadItLater
//
//  Created by Mac on 15/07/26.
//

import Foundation
import Observation


@Observable
final class HomeViewModel {


    private let repository = ArticleRepository()



    var articles: [Article] {

        repository.articles

    }



    var debugInfo: DebugInfo {

        repository.debugInfo

    }



    func addReadingTime(
        _ elapsed: TimeInterval,
        to articleID: UUID
    ) {


        repository.addReadingTime(
            elapsed,
            to: articleID
        )

    }
    
    func reload() {

        repository.reload()

    }

}
