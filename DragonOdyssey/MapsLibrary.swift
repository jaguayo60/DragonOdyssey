//
//  MapsLibrary.swift
//  DragonOdyssey
//
//  Created by Jared on 11/17/20.
//  Copyright © 2020 Wired Betterment. All rights reserved.
//

import UIKit

class MapsLibrary: NSObject {
    static let maps: [[String:Any]] = [
        ["id":"001",
         "name":"Grasslands",
         "bgImageName":"mapGrasslands",
         "timeLengthInSeconds":Double(3*60),
         "level":Double(1),
         "energyCost":Double(1),
         "rewardExperience":Double(300),
         "rewardFoodItems":["strawberry"]
        ],
        ["id":"010",
         "name":"Desert",
         "bgImageName":"mapDesert",
         "timeLengthInSeconds":Double(10*60),
         "level":Double(3),
         "energyCost":Double(5),
         "rewardExperience":Double(700),
         "rewardFoodItems":["strawberry","mango"]
        ],
        ["id":"020",
         "name":"Ocean",
         "bgImageName":"mapOcean",
         "timeLengthInSeconds":Double(20*60),
         "level":Double(5),
         "energyCost":Double(10),
         "rewardExperience":Double(1200),
         "rewardFoodItems":["strawberry","strawberry","bread"]
        ]
    ]
}
