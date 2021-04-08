//
//  User.swift
//  DragonOdyssey
//
//  Created by James Sedlacek on 4/6/21.
//  Copyright © 2021 Wired Betterment. All rights reserved.
//

import UIKit
import CoreLocation

struct User {
    static var shared = User(firebaseUID: "",
                             username: "",
                             email: "",
                             steps: 0,
                             tokens: 0,
                             inventory: [],
                             creatures: [])
    var firebaseUID: String
    var username: String
    var email: String
    var steps: Int
    var tokens: Int
    var inventory: [(name: String, amount: Int)]
    var creatures: [Creature]
    
    func getItemAmount(for name: String) -> Int {
        for item in inventory {
            if item.name == name {
                return item.amount
            }
        }
        return 0
    }
    
    func incrementSteps(stepsToIncrement: Int) {
        if stepsToIncrement == 0 { return }
        //TODO: Server call to increment steps
        // call this function once a minute
    }
    
    func useItem(name: String) {
        //TODO: Server call to use item
    }
    
    func buyItem(name: String) {
        //TODO: Server call to buy item
    }
    
    func addCreature() {
        //TODO: Server call to add creature
    }
}
