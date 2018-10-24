//
//  Card.swift
//  Concentration
//
//  Created by student on 9/5/18.
//  Copyright © 2018 Yorranshell. All rights reserved.
//

import Foundation
struct Card {
    var isFaceUp = false
    var isMatched = false
    var viewcount: Int = 0
    var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int{
        identifierFactory += 1
        return identifierFactory
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }//"self" in swift is the same thing as "this" in Java
}


