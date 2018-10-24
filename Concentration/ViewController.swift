//
//  ViewController.swift
//  Concentration
//
//  Created by student on 8/29/18.
//  Copyright © 2018 Yorranshell. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //Delayed initialization - Initialize when the user refers to it since we cant refer to cardButtons before it exists
    private lazy var game = Concentration(numberOfPairsOfCards: ((cardButtons.count + 1)/2) )
    
    //Control + drag appropriate buttons to this array
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet var newGameButton: UIButton!
    
    @IBOutlet var scoreboardLabel: UILabel!
    
    @IBOutlet var flipCountLabel: UILabel!
    
    private var emoji = Dictionary<Int, String>()
    
    private var emojiThemes: Array<Array<String>> = [
        ["🍭","🍕","🐣","🙈","🦁","🌹","💦","🍆","🤪","👀"], //Mixed
        ["🎃","👻","👹","👺","🧛‍♀️","🧟‍♂️","🧚‍♀️","🦉","🤡","☠️"], //Halloween
        ["🎁","🎉","🎊","🍾","💃","🕺","👯‍♀️","🎈","💅","🎵"], //Party
        ["🐶","🐘","🐇","🦋","🐻","🦁","🐣","🐬","🐱","🐧"], //Animals
        ["🥗","🌶","🍭","🍕","🥝","🍓","🍱","🍆","🍤","🍎"], //Food
        ["📚","✏️","📊","📙","✂️","📐","🖇","🖊","🏫","🎓"], //School
        ["⛱","🏝","🏄‍♀️","🏊‍♂️","🚣‍♀️","🌊","🛶","🛳","⚓️","🤽‍♀️"] ] //Aquatic
    
    //Game starts with a random theme
    private lazy var x = Int((arc4random_uniform(UInt32(emojiThemes.count))))
    
    //No longer needed since flipCount and score are now tracked in Concentration.swift
    //    private(set) var flipCount = 0 {
    //        didSet{ //"didSet" is an observer
    //            flipCountLabel.text = "Flips: \(flipCount)"
    //            }
    //    }
    //
    //    private(set) var score = 0 {
    //        didSet{
    //            scoreboardLabel.text = "Score: \(score)"
    //        }
    //    }
    
    @IBAction func newGame(_ sender: UIButton) {
        print("segue to next view controller")
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender){
            print("card with index: \(cardNumber) was chosen.")
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }else{
            print("chosen card not in the collection")
        }
    }
    
    //Checks card identifier to return corresponding emoji
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil {
            if emojiThemes[x].count > 0 { //emoji choices for theme
                let randomIndex = Int((arc4random_uniform(UInt32(emojiThemes[x].count))))
                emoji[card.identifier] = emojiThemes[x][randomIndex]
                emojiThemes[x].remove(at: randomIndex)
            }
        }
        return emoji[card.identifier] ?? "?" //access the dictionary or return "?" if nil
    }
    
    private func updateViewFromModel(){
        //Update theme
        switch x{ //breaks are not needed in swift
        case 2,4,5:
            self.view.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
            scoreboardLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            flipCountLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            newGameButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: UIControlState.normal)
        case 3,6:
            self.view.backgroundColor = #colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 1)
        default:
            self.view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        //Update numericals
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreboardLabel.text = "Score: \(game.score)"
        
        //Update cards
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle( emoji(for: card), for: UIControlState.normal )
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
            else{
                button.setTitle( "", for: UIControlState.normal )
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 0) : #colorLiteral(red: 0.8823529412, green: 0.9254901961, blue: 1, alpha: 1)  //example of ternary operator
            }
        }
    }
    
}
