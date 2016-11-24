//
//  BusLine.swift
//  BusTracker-iOS
//
//  Created by Lucas Rollet on 23/11/2016.
//  Copyright © 2016 Lucas Rollet. All rights reserved.
//

import UIKit

class BusLine: NSObject {
    var name: String
    var start: String
    var terminus: String
    var direction: String
    var id: String
    
    init(name: String, start: String, terminus: String, direction: String, id: String) {
        self.name = name
        self.start = start
        self.terminus = terminus
        self.direction = direction
        self.id = id
    }
}
