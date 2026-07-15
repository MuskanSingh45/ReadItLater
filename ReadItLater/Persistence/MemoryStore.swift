//
//  MemoryStore.swift
//  ReadItLater
//
//  Created by Mac on 15/07/26.
//

import Foundation
import Observation

@Observable
final class MemoryStore {
    
    private(set) var articles: [Article] = []
    
    init(articles: [Article] = []) {
        self.articles = articles
    }
    
    func load() -> [Article] {
        articles
    }
    
    func save(_ articles: [Article]){
        self.articles = articles
    }
}
