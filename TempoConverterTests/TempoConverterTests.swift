//
//  TempoConverterTests.swift
//  TempoConverterTests
//
//  Created by Josh Reep on 10/23/24.
//

import Foundation
import Testing
@testable import TempoConverter

struct TempoConverterTests {

    @Test("Asserts tap tempo engine works")
    func tapTempoEngineTest() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        let tapTempoEngine = TapTempoEngine(taps: [
            Date(timeIntervalSince1970: 0),
            Date(timeIntervalSince1970: 1),
            Date(timeIntervalSince1970: 1.99234),
            Date(timeIntervalSince1970: 2.982345),
            Date(timeIntervalSince1970: 4.091),
        ])

        #expect(tapTempoEngine.tempoMS?.rounded() == 1023.0)
        #expect(tapTempoEngine.tempoBPM == 59)
    }

}
