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
    // All Pills array
    var pillsArray = [Pill]()
    
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
        return pillsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Create Cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderCell", for: indexPath) as? PillTableViewCell else {
            fatalError("Could not register cell with identifier ReminderCell")
        }
        
        cell.pillNameCell.text = pillsArray[indexPath.row].pillNames
        cell.instructionsCell.text = pillsArray[indexPath.row].pillInstructions
        cell.pillTimerCell.text = pillsArray[indexPath.row].pillStartTimer
        cell.pillImageView.backgroundColor = pillsArray[indexPath.row].pillColor
        
        // Add color to pill taken img
        if pillsArray[indexPath.row].pillTaken == true {
            cell.doneImageView.backgroundColor = .green
        } else {
            cell.doneImageView.backgroundColor = .red
        }
        
        return cell
    }
    
    //MARK:- TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Toggle pill taken when selected
        pillsArray[indexPath.row].pillTaken = !pillsArray[indexPath.row].pillTaken
        
        // Force data source metheds to reload
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
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

