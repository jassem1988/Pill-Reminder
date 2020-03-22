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
    
    var selectedIndexPath: IndexPath?
    
    let items = [Int](1...10)
    
    var allPillNames = [String]()
    var allPillDoses = [Int]()
    var allPillTypes = ["Taps", "Pills", "g", "mg", "mcg"]
    var allPillTimers = [String]()
    var allPillInstructions = [String]()
    var allPillColors = [UIColor]()
    
    override func viewWillAppear(_ animated: Bool) {
        //reload table rows
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add title to Nav Controller
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        titleLabel.textColor = UIColor.darkGray
        titleLabel.text = "Add Pills"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Baskerville-Bold", size: 30)
        navigationItem.titleView = titleLabel
        
        // Register Cell
        self.registerCell()
        
        
    }
    
    //MARK:- TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPillNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderCell", for: indexPath) as? PillTableViewCell else {
            fatalError("Could not register cell with identifier ReminderCell")
        }
        
        cell.pillNameCell.text = allPillNames[indexPath.row]
        cell.instructionsCell.text = allPillInstructions[indexPath.row]
        cell.pillTimerCell.text = allPillTimers[indexPath.row]
        cell.pillImageView.backgroundColor = allPillColors[indexPath.row]
        
        return cell
    }
    
    
    //MARK:- PillCell own methods
    
    func registerCell() {
        let pillCell = UINib(nibName: "PillTableViewCell", bundle: nil)
        self.tableView.register(pillCell, forCellReuseIdentifier: "ReminderCell")
    }
    
    //MARK:- Actions and Segue Methods
    
    @IBAction func saveButtonPressed(segue: UIStoryboardSegue) {
        // add logic here to handle a transition back from the
        // name controller resulting from a user tapping on Save
    }
    
    
}

