//
//  GameViewModel.swift
//  Cirulla
//
//  Created by VFERREROW1 on 26/02/25.
//

import UIKit

enum Turn {
    case player1
    case player2
}

class GameViewModel {
    
    var deck: Deck = Deck(cards: [])
    
    var player1Hand: [Card] = []
    var player2Hand: [Card] = []
    
    var currentTurn: Turn = .player1
    
    func switchTurn() {
        currentTurn = (currentTurn == .player1) ? .player2 : .player1
    }
    
    // MARK: Metodo per generare il mazzo
    func createDeck() -> [Card] {
        var deck: [Card] = []
        
        for seed in Seed.allCases {
            for rank in Rank.allCases {
                deck.append(Card(seed: seed, rank: rank, image: UIImage(named: rank.rawValue.lowercased())))
            }
        }
        return deck
    }
    
    func dealCard() -> ([Card], [Card]) {
        guard let deckCards = deck.cards, deckCards.count >= 6 else { return ([], []) }
        
        player1Hand = Array(deckCards.prefix(3))
        player2Hand = Array(deckCards.dropFirst(3).prefix(3))
        
        deck.cards?.removeFirst(6)
        
        return (player1Hand, player2Hand)
    }
    
    func takeCard() {
        // TODO: metodo che pesca una carta
        // TODO: aggiorna il valore del count
        
        /* Utile per un metodo "pesca carta"
        let firstCard = self.viewModel.deck.cards?.first
        print(firstCard?.rank.rawValue ?? "Nessuna carta")
        */
    }
    
    // MARK: Metodo per contare le carte del mazzo
    func getCounterDeck() -> Int {
        return self.deck.cards?.count ?? 0
    }
    
    func printDeck() {
        if let deck = deck.cards {
            for card in deck {
                print("\(card.rank.rawValue) di \(card.seed.rawValue) (Valore: \(card.value))")
            }
        }
    }
    
}
