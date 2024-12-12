//
//  SubdivisionSettingForm.swift
//  TempoConverter
//
//  Created by Josh Reep on 11/4/24.
//

import SwiftUI
import SwiftData

enum FormType {
    case add
    case edit
}

struct SubdivisionSettingForm: View {
    @Bindable var subdivisionSetting: SubdivisionSetting

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    var formType: FormType = .add

    private var headerText: String {
        switch formType {
        case .add:
            "Add New Subdivision"
        case .edit:
            "Edit Subdivision"
        }
    }


    private var buttonIcon: String {
        switch formType {
        case .add:
            "plus"
        case .edit:
            "checkmark"
        }
    }

    var body: some View {
        Form {
            Picker("Modifier", selection: $subdivisionSetting.modifier) {
                ForEach(modifierDictionary.sorted { $0.value > $1.value }, id: \.key) { key, value in
                    Text("\(value.isEmpty ? "Regular" : value)")
                        .tag(key)
                }
            }

            Picker("Subdivision", selection: $subdivisionSetting.subdivision) {
                ForEach(subdivisionDictionary.sorted(by: >), id: \.key) { key, value in
                    Text("\(value) Note")
                        .tag(key)
                }
            }
        }
        .navigationTitle(headerText)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if formType == .add {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        if formType == .add {
                            context.delete(subdivisionSetting)
                        }
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SubdivisionSettingForm(
            subdivisionSetting: SampleData.shared.subdivisionSetting,
            formType: .edit
        )
    }
}

#Preview("New Subdivision Setting") {
    NavigationStack {
        SubdivisionSettingForm(
            subdivisionSetting: SampleData.shared.subdivisionSetting,
            formType: .add
        )
    }
}
