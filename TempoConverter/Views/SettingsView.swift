//
//  SettingsView.swift
//  TempoConverter
//
//  Created by Josh Reep on 10/23/24.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \SubdivisionSetting.order) private var subdivisions: [SubdivisionSetting]

    @State private var newSubdivisionSetting: SubdivisionSetting?

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(subdivisions.sorted { $0.order < $1.order }) { sub in
                    NavigationLink(sub.label) {
                        SubdivisionSettingForm(subdivisionSetting: sub, formType: .edit)
                            .navigationTitle("Edit")
                            .navigationBarTitleDisplayMode(.inline)
                    }
                }
                .onDelete(perform: deleteItems)
                .onMove { from, to in
                    var temp = subdivisions.sorted(by: { $0.order < $1.order })
                    temp.move(fromOffsets: from, toOffset: to)

                    for (index, item) in temp.enumerated() {
                        item.order = index
                    }
                    
                    try? self.context.save()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button("Add Subdivision", systemImage: "plus", action: addItem)
                }
            }
            .navigationTitle("Settings")
            .sheet(item: $newSubdivisionSetting) { sub in
                NavigationStack {
                    SubdivisionSettingForm(subdivisionSetting: sub, formType: .add)
                }
                .interactiveDismissDisabled()
            }
        } detail: {
            Text("Edit Subdivision Setting")
                .navigationTitle("Subdivision")
                .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func addItem() {
        withAnimation {
            let newSubdivisionSetting = SubdivisionSetting(
                subdivision: 1.0,
                modifier: .none,
                order: (try? context.fetchCount(FetchDescriptor<SubdivisionSetting>())) ?? 0
            )
            context.insert(newSubdivisionSetting)
            self.newSubdivisionSetting = newSubdivisionSetting
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                context.delete(subdivisions[index])
            }
        }
    }
}

#Preview {
    SettingsView()
        .modelContainer(SampleData.shared.modelContainer)

}
