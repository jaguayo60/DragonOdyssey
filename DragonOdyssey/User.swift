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
    static var shared = User(id: "",
                             firebaseUID: "",
                             username: "",
                             email: "",
                             steps: 0,
                             inventory: [],
                             creatures: [])
    var id: String
    var firebaseUID: String
    var username: String
    var email: String
    var steps: Int
    var inventory: [Item]
    var creatures: [Creature]
    
    func incrementSteps(stepsToIncrement: Int) {
        if stepsToIncrement == 0 { return }
        //TODO: Server call to increment steps
        // call this function once a minute
    }
    
    func useItem(item: Item) {
        //TODO: Server call to use item
    }
    
    func buyItem(item: Item) {
        //TODO: Server call to buy item
    }
    
    func addCreature() {
        //TODO: Server call to add creature
    }
}
