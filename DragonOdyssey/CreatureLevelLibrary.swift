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
            "maxEnergy":3
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
        [
            "level":4,
            "totalStepsForLevel":28000,
            "stepsToNextLevel":17000,
            "maxEnergy":16
        ],
        [
            "level":5,
            "totalStepsForLevel":45000,
            "stepsToNextLevel":23000,
            "maxEnergy":20
        ],
        [
            "level":6,
            "totalStepsForLevel":68000,
            "stepsToNextLevel":30000,
            "maxEnergy":25
        ],
        [
            "level":7,
            "totalStepsForLevel":98000,
            "stepsToNextLevel":38000,
            "maxEnergy":30
        ],
        [
            "level":8,
            "totalStepsForLevel":136000,
            "stepsToNextLevel":47000,
            "maxEnergy":36
        ],
        [
            "level":9,
            "totalStepsForLevel":183000,
            "stepsToNextLevel":57000,
            "maxEnergy":42
        ],
        [
            "level":10,
            "totalStepsForLevel":240000,
            "stepsToNextLevel":68000,
            "maxEnergy":50
        ],
    ]
}
