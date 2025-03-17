//
//  Deck.swift
//  Cirulla
//
//  Created by VFERREROW1 on 24/02/25.
//

import UIKit

enum Seed: String, CaseIterable {
    case hears = "Cuori"
    case diamonds = "Quadri"
    case flowers = "Fiori"
    case spades = "Picche"
}

enum Rank: String, CaseIterable {
    case ace = "Asso"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case jack = "Fante"
    case queen = "Donna"
    case king = "Re"

    var value: Int {
        switch self {
        case .ace: return 11
        case .two: return 2
        case .three: return 3
        case .four: return 4
        case .five: return 5
        case .six: return 6
        case .seven: return 7
        case .jack, .queen, .king: return 10
        }
    }
}

struct Card {
    let seed: Seed
    let rank: Rank
    var value: Int { rank.value }
    let image: UIImage?
}

struct Deck {
    var cards: [Card]?
}
