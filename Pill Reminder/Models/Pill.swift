//
//  Pill.swift
//  Pill Reminder
//
//  Created by Jassem Al-Buloushi on 3/24/20.
//  Copyright © 2020 Jassem Al-Buloushi. All rights reserved.
//

import Foundation
import UIKit

class Pill {
    
    var pillNames: String = ""
    var pillInstructions: String = ""
    var pillStartTimer: String = ""
    var pillColor: UIColor = .black
    var pillTypes = ["Taps", "Pills", "g", "mg", "mcg"]
    var intake = ["1 Times a Day", "2 Times a Day", "3 Times a Day", "4 Times a Day"]
    var pillColors : [(colorName: String, color: UIColor)] = [("Red", .red), ("Orange", .orange), ("Magenta", .magenta)]
}
