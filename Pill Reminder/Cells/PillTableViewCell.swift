//
//  PillTableViewCell.swift
//  Pill Reminder
//
//  Created by Jassem Al-Buloushi on 3/5/20.
//  Copyright © 2020 Jassem Al-Buloushi. All rights reserved.
//

import UIKit

class PillTableViewCell: UITableViewCell {
    
    //MARK:- Outlets
    @IBOutlet var pillImageView: UIImageView!
    @IBOutlet var pillNameCell: UILabel!
    @IBOutlet var instructionsCell: UILabel!
    @IBOutlet var pillTimerCell: UILabel!
    @IBOutlet var doneImageView: UIImageView!
    @IBOutlet var pillsLeft: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
