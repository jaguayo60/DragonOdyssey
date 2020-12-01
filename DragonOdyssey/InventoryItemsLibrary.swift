//
//  InventoryItemsLibrary.swift
//  DragonOdyssey
//
//  Created by Jared on 10/30/20.
//  Copyright © 2020 Wired Betterment. All rights reserved.
//

import UIKit

class InventoryItemsLibrary: NSObject {
    
    static func itemDictWith(id: String) -> [String:Any]? {
        for item in inventoryItemsArray {
            guard let itemID = item["id"] as? String else { continue }
            if id == itemID { return item }
        }
        return nil
    }
    
    static var inventoryItemsArray = [
        
        ["id":"strawberry",
         "imageName":"strawberry",
         "name":"Strawberry",
         "energyAmount":Double(1),
         "tokenCost":Double(1),
         "sortPriority":Double(90)
        ],
        ["id":"mango",
         "imageName":"mango",
         "name":"Mango",
         "energyAmount":Double(3),
         "tokenCost":Double(5),
         "sortPriority":Double(85)
        ],
        ["id":"bread",
         "imageName":"bread",
         "name":"Bread",
         "energyAmount":Double(4),
         "isAdOnly":true,
         "sortPriority":Double(80)
        ],
        ["id":"watermelon",
         "imageName":"watermelon",
         "name":"Watermelon",
         "energyAmount":Double(5),
         "tokenCost":Double(10),
         "sortPriority":Double(75)
        ],
        ["id":"cake",
         "imageName":"cake",
         "name":"Cake",
         "energyAmount":Double(7),
         "isAdOnly":true,
         "sortPriority":Double(70)
        ],
        ["id":"fish",
         "imageName":"fish",
         "name":"Fish",
         "energyAmount":Double(10),
         "tokenCost":Double(20),
         "sortPriority":Double(65)
        ],
        ["id":"chicken",
         "imageName":"chicken",
         "name":"Chicken",
         "energyAmount":Double(15),
         "tokenCost":Double(35),
         "sortPriority":Double(60)
        ],
        ["id":"stew",
         "imageName":"stew",
         "name":"Stew",
         "energyAmount":Double(20),
         "isAdOnly":true,
         "sortPriority":Double(55)
        ],
        ["id":"sheep",
         "imageName":"sheep",
         "name":"Sheep",
         "energyAmount":Double(30),
         "tokenCost":Double(50),
         "sortPriority":Double(50)
        ],
        ["id":"deer",
         "imageName":"deer",
         "name":"Deer",
         "energyAmount":Double(40),
         "tokenCost":Double(75),
         "sortPriority":Double(45)
        ],
    ]
}
