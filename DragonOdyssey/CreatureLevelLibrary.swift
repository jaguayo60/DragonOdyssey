//
//  CreatureLevelLibrary.swift
//  DragonOdyssey
//
//  Created by Jared on 11/12/20.
//  Copyright © 2020 Wired Betterment. All rights reserved.
//

import UIKit

class CreatureLevelLibrary: NSObject {

    static let creatureLevelDicts: [[String : Any]] = [
        [
            "level":0,
            "totalStepsForLevel":0,
            "stepsToNextLevel":3000,
            "maxEnergy":5
        ],
        [
            "level":1,
            "totalStepsForLevel":3000,
            "stepsToNextLevel":5000,
            "maxEnergy":5
        ],
        [
            "level":2,
            "totalStepsForLevel":8000,
            "stepsToNextLevel":8000,
            "maxEnergy":8
        ],
        [
            "level":3,
            "totalStepsForLevel":16000,
            "stepsToNextLevel":12000,
            "maxEnergy":12
        ],
    ]
}
