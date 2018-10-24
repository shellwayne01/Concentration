//
//  Concentration.swift
//  Concentration
//
//  Created by student on 9/5/18.
//  Copyright © 2018 Yorranshell. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    var score: Int = 0
    var flipCount: Int = 0
    var newValue: Int?
    
    //Returns the index of the FaceUpCard if applicable
    private var indexOfOneAndOnlyFaceUpCard: Int?{
        get{
            var foundIndex: Int?
            for index in cards.indices{
                if cards[index].isFaceUp{
                    if foundIndex == nil{
                        foundIndex = index
                    } else {
                        foundIndex = nil
                    }
                }
            }
            return foundIndex
        }
        set(newValue){
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)  //REVIEW!!!
            }
        }
    }
    
    //Note: "at" is the external name and "index" is the internal name so user will call chooseCard(at 5).
    func chooseCard(at index: Int){
        if !cards[index].isMatched{
            flipCount += 1
            cards[index].viewcount += 1 //how many times current card has been seen
            //if the current card is not matched yet--and its not the same card previously chosen then check to see if both current and previous cards match.
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                print("prev card  \(cards[matchIndex].identifier) was viewed \(cards[matchIndex].viewcount) times.")
                print("current card  \(cards[index].identifier) was viewed \(cards[index].viewcount) times.")
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                }else{
                    if cards[index].viewcount >= 2{
                        score -= 1}
                    if cards[matchIndex].viewcount >= 2{
                        score -= 1}
                }
            }
            else {
                print("awaiting second selection...")
                indexOfOneAndOnlyFaceUpCard = index
                for flipDownIndex in cards.indices{
                    cards[flipDownIndex].isFaceUp = false
                }
            }
            cards[index].isFaceUp = true
        }
        else{
            cards[index].isFaceUp = false
        }
    }
    
    //Note: Example of an exclusive range in the for loop. For inclusive you would do 0...variable. Also variable name is optional since you can just used underscore.
    init(numberOfPairsOfCards: Int){
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card,card]
        }
        //Shuffle Cards
        var originalcards = cards
        for index in originalcards.indices{
            let randomIndex = Int((arc4random_uniform(UInt32(originalcards.count))))
            cards[index] = originalcards[randomIndex]
            originalcards.remove(at: randomIndex)
        }
    }
}
