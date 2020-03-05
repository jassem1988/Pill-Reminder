//
//  HomeViewController.swift
//  Pill Reminder
//
//  Created by Jassem Al-Buloushi on 3/3/20.
//  Copyright © 2020 Jassem Al-Buloushi. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {
    
    //Properties
    
    let items = [Int](1...10)
    
    var allPillNames = [String]()
    var allPillDoses = [Int]()
    var allPillTypes = ["Taps", "Pills", "g", "mg", "mcg"]
    var allPillInstructions = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerCell()
        
    }
    
    //MARK:- TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderCell", for: indexPath) as? PillTableViewCell else {
            fatalError("Could not register cell with identifier ReminderCell")
        }
        
//        cell.textLabel?.text = String(items[indexPath.row])
        
        cell.pillNameCell.text = String(items[indexPath.row])
        
        
        return cell
    }
    
    
    //MARK:- PillCell own methods
    
    func registerCell() {
        let pillCell = UINib(nibName: "PillTableViewCell", bundle: nil)
        self.tableView.register(pillCell, forCellReuseIdentifier: "ReminderCell")
    }


}

