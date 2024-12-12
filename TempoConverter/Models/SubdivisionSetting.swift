//
//  Item.swift
//  TempoConverter
//
//  Created by Josh Reep on 10/23/24.
//

import Foundation
import SwiftData

enum SubdivisionModifier: Codable {
    case dotted
    case triplet
    case none
}

let modifierDictionary: Dictionary<SubdivisionModifier, String> = [
    SubdivisionModifier.none: "",
    SubdivisionModifier.dotted: "Dotted",
    SubdivisionModifier.triplet: "Triplet"
]

let subdivisionDictionary = [
    4.0: "Whole",
    2.0: "Half",
    1.0: "Quarter",
    0.5: "Eighth",
    0.25: "Sixteenth",
]

let dottedModifierValue = 3.0 / 4.0
let tripletModiferValue = 2.0 / 3.0

@Model
class SubdivisionSetting {
    var subdivision: Double
    var modifier: SubdivisionModifier
    var order: Int

    init(subdivision: Double, modifier: SubdivisionModifier = .none, order: Int) {
        self.subdivision = subdivision
        self.modifier = modifier
        self.order = order
    }

    var computedSubdivision: Double {
        switch self.modifier {
        case .dotted:
            self.subdivision * dottedModifierValue
        case .triplet:
            self.subdivision * tripletModiferValue
        case .none:
            self.subdivision
        }
    }

    var label: String {
        let peices: [String?] = [
            modifierDictionary[modifier],
            subdivisionDictionary[subdivision],
            "Note",
        ]

        let filteredPeices = peices.filter { $0?.isEmpty != true } as? [String]

        return filteredPeices?.joined(separator: " ") ?? ""

    }

    @MainActor static let sampleData = [
        SubdivisionSetting(subdivision: 1.0, order: 0),
        SubdivisionSetting(subdivision: 0.5, order: 1),
        SubdivisionSetting(subdivision: 1.0, modifier: .triplet, order: 2),
    ]
}

extension [SubdivisionSetting] {
    func updateOrderIndicies() {
        for (index, item) in enumerated() {
            item.order = index
        }
    }
}
