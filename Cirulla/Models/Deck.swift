//
//  Deck.swift
//  Cirulla
//
//  Created by VFERREROW1 on 24/02/25.
//

import UIKit

enum Seed: String {
    case hears = "Cuori"
    case diamonds = "Quadri"
    case flowers = "Fiori"
    case spades = "Picche"
}

enum Rank: String {
    case ace = "Asso" // 11?
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case ten = "10"
    case jack = "Fante" // 1212?
    case queen = "Donna" // 1221?
    case king = "Re" // 12212??
}

struct Card {
    let seed: Seed?
    let number: Rank?
    let value: Int?
    let image: UIImage?
}

struct Deck {
    let cards: [Card]?
}
