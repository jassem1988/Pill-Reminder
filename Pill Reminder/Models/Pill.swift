//
//  Pill.swift
//  Pill Reminder
//
//  Created by Jassem Al-Buloushi on 3/24/20.
//  Copyright © 2020 Jassem Al-Buloushi. All rights reserved.
//

import Foundation
import UIKit

class Pill: Encodable {
    
    // Selected options
    var pillTaken = false
    var selectedPillType: String?
    var selectedIntake: String?
//    var selectedColor: UIColor?
    var selectedColorString: String?
    
    // Date and Time
    var userSelectedDateStart: String?
    var userSelectedDateEnd: String?
    var userSelectedTimeStart: String?
    var userSelectedTimeEnd: String?
    
    // User input
    var pillName: String = ""
    var pillInstruction: String = ""
    var pillStartTimer: String = ""
//    var pillColor: UIColor = .black
    
    // Static options
    static var pillTypes = ["Taps", "Pills", "g", "mg", "mcg"]
    static var intake = ["1 Times a Day", "2 Times a Day", "3 Times a Day", "4 Times a Day"]
    static var pillColors : [(colorName: String, color: UIColor)] = [("Red", .red), ("Orange", .orange), ("Magenta", .magenta)]
}
