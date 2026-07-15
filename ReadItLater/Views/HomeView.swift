//
//  HomeView.swift
//  ReadItLater
//
//  Created by Mac on 15/07/26.
//

import SwiftUI
import UIKit

struct HomeView: View {

    @State private var viewModel = HomeViewModel()

    var body: some View {

        List {

            ForEach(viewModel.articles) { article in

                NavigationLink {

                    ReaderView(
                        article: article
                    ) { elapsed in

                        viewModel.addReadingTime(
                            elapsed,
                            to: article.id
                        )

                    }

                } label: {

                    ArticleRow(article: article)

                }

            }

        }
        .listStyle(.plain)
        .navigationTitle("Read It Later")

        .onReceive(
            NotificationCenter.default.publisher(
                for: UIApplication.willEnterForegroundNotification
            )
        ) { _ in

            viewModel.reload()

        }

        .toolbar {

            NavigationLink {

                DebugView(
                    info: viewModel.debugInfo
                )

            } label: {

                Image(systemName: "ladybug")

            }

        }

    }

}

#Preview {

    NavigationStack {

        HomeView()

    }

}
