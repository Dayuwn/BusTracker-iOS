//
//  BusStop.swift
//  BusTracker-iOS
//
//  Created by Lucas Rollet on 23/11/2016.
//  Copyright © 2016 Lucas Rollet. All rights reserved.
//

import UIKit

class BusStop: NSObject {
    var id: String
    var name: String
    var service: String
    
    init(id: String, name: String, service: String) {
        self.id = id
        self.name = name
        self.service = service
    }
}
