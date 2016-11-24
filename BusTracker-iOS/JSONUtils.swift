//
//  JSONUtils.swift
//  BusTracker-iOS
//
//  Created by Lucas Rollet on 23/11/2016.
//  Copyright © 2016 Lucas Rollet. All rights reserved.
//

import Foundation

class JSONUtils: NSObject {
    static func loadData(from url: URL) -> JSON? {
        if let data = try? Data(contentsOf: url) {
            let json = JSON(data: data)
            return json
        }
        return nil
    }
}
