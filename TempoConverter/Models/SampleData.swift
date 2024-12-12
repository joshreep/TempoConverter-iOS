//
//  SampleData.swift
//  TempoConverter
//
//  Created by Josh Reep on 10/28/24.
//

import Foundation
import SwiftData

@MainActor
class SampleData {
    static let shared = SampleData()

    let modelContainer: ModelContainer

    var context: ModelContext {
        modelContainer.mainContext
    }

    var subdivisionSetting: SubdivisionSetting {
        SubdivisionSetting.sampleData.first!
    }

    private init() {
        let schema = Schema([SubdivisionSetting.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)

        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])

            insertSampleData()

            try context.save()
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }

    private func insertSampleData() {
        for subdivisionSetting in SubdivisionSetting.sampleData {
            context.insert(subdivisionSetting)
        }
    }
}
