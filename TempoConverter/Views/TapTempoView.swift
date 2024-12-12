//
//  TapTempoView.swift
//  TempoConverter
//
//  Created by Josh Reep on 10/23/24.
//

import SwiftUI
import SwiftData

struct TapTempoView: View {
    @Query(sort: \SubdivisionSetting.order) private var subdivisionSettings: [SubdivisionSetting]
    @Environment(\.modelContext) private var context

    @State private var tapTempoEngine = TapTempoEngine()
    @State private var buttonPress = false

    @FocusState private var inputFocused: Bool

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            TextField("BPM", text: $tapTempoEngine.tempoBPM)
                .textFieldStyle(.plain)
                .font(.system(size: 60, design: .default))
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
                .focused($inputFocused)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            inputFocused = false
                        }
                    }
                }
                .onSubmit {
                    tapTempoEngine.tempoBPM = value
                }

            List(subdivisionSettings) { sub in
                HStack {
                    Text(sub.label)
                    Spacer()
                    Text("\(Int((tapTempoEngine.tempoMS * sub.computedSubdivision).rounded())) ms")
                }
            }

            Spacer()

            Button("Tap", systemImage: "hand.tap.fill") {
                handleTap()
            }
            .font(.largeTitle)
            .symbolRenderingMode(.hierarchical)
            .buttonBorderShape(.capsule)
            .controlSize(.extraLarge)
            .buttonStyle(.bordered)
            .symbolEffect(.bounce, options: .speed(100), value: buttonPress)
        }
        .padding()
    }

    private func handleTap() {
        tapTempoEngine.handleTap()
        buttonPress.toggle()
    }

}

#Preview {
    TapTempoView()
        .modelContainer(SampleData.shared.modelContainer)
}
