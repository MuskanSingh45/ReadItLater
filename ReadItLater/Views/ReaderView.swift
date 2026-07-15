//
//  ReaderView.swift
//  ReadItLater
//
//  Created by Mac on 15/07/26.
//

import SwiftUI

struct ReaderView: View {

    let article: Article

    let onReadingFinished: (TimeInterval) -> Void

    @State private var timer = ReadingTimer()

    @Environment(\.scenePhase)
    private var scenePhase


    var body: some View {

        VStack(spacing: 0) {

            HStack {

                Label(
                    timer.currentSessionTime.formattedTime,
                    systemImage: "clock.fill"
                )

                Spacer()

            }
            .padding()
            .background(.thinMaterial)


            HStack {

                Button("Pause") {

                    timer.pause()

                }

                Spacer()

                Button("Resume") {

                    timer.resume()

                }

            }
            .padding()


            WebView(url: article.url)

        }
        .navigationTitle(article.title)
        .navigationBarTitleDisplayMode(.inline)

        .onAppear {

            timer.beginSession()

        }

        .onDisappear {

            let elapsed = timer.stop()

            onReadingFinished(elapsed)

        }

        .onChange(of: scenePhase) { _, newPhase in

            switch newPhase {

            case .active:

                timer.resume()

            case .background:

                timer.pause()

            default:

                break

            }

        }
    }
}


#Preview {

    NavigationStack {

        ReaderView(
            article: MockData.articles[0]
        ) { _ in

        }

    }

}
