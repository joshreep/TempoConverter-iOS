//
//  TapTempoEngine.swift
//  TempoConverter
//
//  Created by Josh Reep on 10/24/24.
//

import Foundation


class TapTempoEngine {
    var numTapsToUse = 5
    var clearAfterSeconds = 2.0

    var taps: [Date] = []
    var tempoMS = 1000.0
    var tempoBPM = "60"

    let debouncer: Debouncer

    init(taps: [Date] = [], numTapsToUse: Int = 5, clearAfterSeconds: Double = 2.0) {
        self.taps = taps
        self.numTapsToUse = numTapsToUse
        self.clearAfterSeconds = clearAfterSeconds
        self.debouncer = Debouncer(delay: clearAfterSeconds)
    }

    func handleTap () {
        let tap = Date.now

        if taps.count == numTapsToUse {
            taps.removeFirst()
        }
        taps.append(tap)

        if taps.count > 1 {
            let exactMsTiming = taps.last!.timeIntervalSince(taps.first!) * 1000 / Double(taps.count - 1)
            let tempoBPMInt = Int((60000.0 / exactMsTiming).rounded())
            tempoBPM = "\(tempoBPMInt)"
            tempoMS = 60000.0 / Double(tempoBPMInt)
        }

        debouncer.debounce {
            self.clearTaps()
        }
    }

    func clearTaps () {
        taps = []
    }
}

