//
//  ShareViewController.swift
//  ReadItLaterShare
//
//  Created by Mac on 15/07/26.
//

import UIKit
import Social
import UniformTypeIdentifiers

class ShareViewController: SLComposeServiceViewController {

    override func didSelectPost() {

        guard let item =
            extensionContext?.inputItems.first
                as? NSExtensionItem else {

            close()
            return
        }

        guard let attachments =
            item.attachments else {

            close()
            return
        }

        for provider in attachments {

            if provider.hasItemConformingToTypeIdentifier(
                UTType.url.identifier
            ) {

                provider.loadItem(
                    forTypeIdentifier: UTType.url.identifier,
                    options: nil
                ) { item, error in

                    if let url = item as? URL {

                        self.save(url)

                    }

                    self.close()
                }

                return
            }
        }

        close()
    }
    
    private func save(_ url: URL) {

        let disk = DiskStore()

        var articles = (try? disk.load()) ?? []

        print("📖 Articles before save:", articles.count)

        let article = Article(
            url: url,
            title: url.host ?? url.absoluteString
        )

        articles.append(article)

        print("📖 Articles after append:", articles.count)

        do {

            try disk.save(articles)

            print("✅ Saved article:", url.absoluteString)

        } catch {

            print("❌ Save failed:", error)

        }

    }

    private func close() {

        DispatchQueue.main.async {

            self.extensionContext?.completeRequest(
                returningItems: nil
            )

        }
    }
}
