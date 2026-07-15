//
//  DebugView.swift
//  ReadItLater
//
//  Created by Mac on 15/07/26.
//

import SwiftUI

struct DebugView: View {

    let info: DebugInfo

    var body: some View {

        List {

            LabeledContent(
                "Memory Articles",
                value: "\(info.memoryArticles)"
            )

            LabeledContent(
                "Disk Articles",
                value: "\(info.diskArticles)"
            )

            LabeledContent(
                "Merge Reason",
                value: info.mergeReason.rawValue
            )

            LabeledContent(
                "Last Merge",
                value: info.lastMerge.formatted()
            )

        }
        .navigationTitle("Debug")

    }

}
