//
//  ArticleRow.swift
//  ReadItLater
//
//  Created by Mac on 15/07/26.
//

import SwiftUI

struct ArticleRow: View {
    
    let article: Article
    
    var body: some View {
        
        HStack(alignment: .top, spacing: 16){
            
            Image(systemName: "doc.text.fill")
                .font(.title2)
                .foregroundStyle(.blue)
                .frame(width: 36)
            
            VStack(alignment: .leading, spacing: 4){
                Text(article.title)
                    .font(.headline)
             
                Text(article.url.host() ?? "")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                HStack {
                    Label(
                        article.totalReadingTime.formattedTime,
                        systemImage: "clock"
                    )
                    .font(.caption)
                    .foregroundStyle(.blue)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.tertiary)
                    
                }
            }
        
        }
        .padding(.vertical, 8)

    }
}

#Preview {
    ArticleRow(article: MockData.articles[1])
}
