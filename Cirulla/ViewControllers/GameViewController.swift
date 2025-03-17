//
//  GameViewController.swift
//  Cirulla
//
//  Created by VFERREROW1 on 20/02/25.
//

import UIKit

class GameViewController: BaseViewController {
    
    private var viewModel = GameViewModel()
    
    // MARK: Button
    @IBOutlet weak var optionButton: UIButton!
    
    // MARK: Label
    @IBOutlet weak var roundPlayerLabel: UILabel!
    @IBOutlet weak var totalCardLabel: UILabel!
    @IBOutlet weak var counterTotalCardLabel: UILabel!
    
    // MARK: ImageView G1
    @IBOutlet weak var g1Card1: UIImageView!
    @IBOutlet weak var g1Card2: UIImageView!
    @IBOutlet weak var g1Card3: UIImageView!
    
    // MARK: ImageView G2
    @IBOutlet weak var g2Card1: UIImageView!
    @IBOutlet weak var g2Card2: UIImageView!
    @IBOutlet weak var g2Card3: UIImageView!
    
    // MARK: ImageView deck & cardPlayed
    @IBOutlet weak var deck: UIImageView!
    @IBOutlet weak var cardPlayed: UIImageView!
    
    // MARK: ImageView stack of cards players
    @IBOutlet weak var stackPlayer2: UIImageView!
    @IBOutlet weak var stackPlayer1: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.totalCardLabel.text = "40"
        self.counterTotalCardLabel.text = "40"
        
        addTapGesture(to: g1Card1)
        addTapGesture(to: g1Card2)
        addTapGesture(to: g1Card3)
        
        addTapGesture(to: g2Card1)
        addTapGesture(to: g2Card2)
        addTapGesture(to: g2Card3)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.step1Game()
    }

    override func setupUI() {
        self.view.backgroundColor = .systemGreen
        
        self.optionButton.layer.cornerRadius = 10
        self.optionButton.backgroundColor = .white
        
        let allCards = [g1Card1,g1Card2,g1Card3,g2Card1,g2Card2,g2Card3,deck].compactMap { $0 }
        
        CardUIManager.shared.setStyleCard(allCards)
    }
    
    func step1Game() {
        
        // Crea e mescola il mazzo
        self.viewModel.deck.cards = self.viewModel.createDeck()
        
        print("Prima di mescolare")
        self.viewModel.printDeck()
        
        self.viewModel.deck.cards?.shuffle()
        
        print("Dopo mescolare")
        self.viewModel.printDeck()
        
        // Distribuisci le carte e aggiorna la UI
        let (g1Cards, g2Cards) = self.viewModel.dealCard()
        updatePlayerHands(g1Cards: g1Cards, g2Cards: g2Cards)
        
        self.counterTotalCardLabel.text = String(describing: self.viewModel.getCounterDeck())
        
        // Aggiorna il turno
        self.updateTurnLabel()
    }
    
    // Metodo per aggiungere il Gesture Recognizer alle carte
    private func addTapGesture(to card: UIImageView) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(cardTapped(_:)))
        card.isUserInteractionEnabled = true // Abilita l’interazione
        card.addGestureRecognizer(tap)
    }
    
    // Metodo chiamato quando una carta viene tappata
    @objc private func cardTapped(_ sender: UITapGestureRecognizer) {
        guard let tappedCard = sender.view as? UIImageView else { return }
        
        // Verifica se la carta appartiene al giocatore di turno
        let isPlayer1Turn = viewModel.currentTurn == .player1
        let player1Cards = [g1Card1, g1Card2, g1Card3]
        let player2Cards = [g2Card1, g2Card2, g2Card3]
        
        if (isPlayer1Turn && !player1Cards.contains(tappedCard)) ||
            (!isPlayer1Turn && !player2Cards.contains(tappedCard)) {
            return // Non permettere di giocare fuori turno
        }
        
        // Converti la posizione della carta rispetto alla vista principale
        let cardFrameInMainView = tappedCard.superview?.convert(tappedCard.frame, to: self.view) ?? tappedCard.frame

        // Crea una copia della carta tappata
        let cardCopy = UIImageView(image: tappedCard.image)
        cardCopy.frame = cardFrameInMainView
        cardCopy.layer.cornerRadius = tappedCard.layer.cornerRadius
        cardCopy.layer.masksToBounds = tappedCard.layer.masksToBounds
        cardCopy.layer.shadowColor = tappedCard.layer.shadowColor
        cardCopy.layer.shadowOpacity = tappedCard.layer.shadowOpacity
        cardCopy.layer.shadowOffset = tappedCard.layer.shadowOffset
        cardCopy.layer.shadowRadius = tappedCard.layer.shadowRadius

        // Aggiungi la copia alla vista principale
        self.view.addSubview(cardCopy)

        // Anima la copia della carta verso il tavolo
        let tablePosition = cardPlayed.center
        CardUIManager.shared.playCardAnimation(cardView: cardCopy, toTablePosition: tablePosition) {
            self.cardPlayed.image = tappedCard.image
            cardCopy.removeFromSuperview()
            tappedCard.image = nil // Rimuove la carta dal giocatore
            self.viewModel.switchTurn() // Cambia turno
            self.updateTurnLabel() // Aggiorna l'interfaccia
        }
    }
    
    func updateTurnLabel() {
        let turnText = (viewModel.currentTurn == .player1) ? "Turno: Giocatore 1" : "Turno: Giocatore 2"
        
        roundPlayerLabel.text = turnText
        roundPlayerLabel.alpha = 0
        UIView.animate(withDuration: 0.5) {
            self.roundPlayerLabel.alpha = 1
        }
    }
    
    func updatePlayerHands(g1Cards: [Card], g2Cards: [Card]) {
        let g1ImageViews = [g1Card1, g1Card2, g1Card3]
        let g2ImageViews = [g2Card1, g2Card2, g2Card3]
        
        for (index, card) in g1Cards.enumerated() {
            g1ImageViews[index]?.image = card.image
        }
        
        for (index, card) in g2Cards.enumerated() {
            g2ImageViews[index]?.image = card.image
        }
    }

    @IBAction func optionButtonTapped(_ sender: Any) {
        print("Tapped")
    }
}

