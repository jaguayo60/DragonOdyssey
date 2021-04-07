//
//  Creature.swift
//  DragonOdyssey
//
//  Created by James Sedlacek on 4/6/21.
//  Copyright © 2021 Wired Betterment. All rights reserved.
//

import UIKit
import CoreLocation

struct Creature {
    var id: String
    var name: String
    var energy: Int
    var maxEnergy: Int
    var agility: Int
    var strength: Int
    var location: CLLocationCoordinate2D
}
