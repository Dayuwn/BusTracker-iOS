//
//  BusLineCellTableViewCell.swift
//  BusTracker-iOS
//
//  Created by Lucas Rollet on 23/11/2016.
//  Copyright © 2016 Lucas Rollet. All rights reserved.
//

import UIKit

class BusLineCell: UITableViewCell {
    @IBOutlet weak var lineNameLabel: UILabel!
    @IBOutlet weak var lineStartLabel: UILabel!
    @IBOutlet weak var lineTerminusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
