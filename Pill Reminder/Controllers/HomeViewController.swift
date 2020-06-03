//
//  HomeViewController.swift
//  Pill Reminder
//
//  Created by Jassem Al-Buloushi on 3/3/20.
//  Copyright © 2020 Jassem Al-Buloushi. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UITableViewController {
    
    //MARK:- Properties
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // All Pills array
    var pillsArray: [Pill] = []
    
    override func viewWillAppear(_ animated: Bool) {
        //reload table rows
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the interface color of User
        overrideUserInterfaceStyle = .light
        
        // Find user directory path for Core Data
        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        print(dataFilePath)
        
        // Load pillsArray
        loadPills()
        
        // Add title to Nav Controller
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
//        titleLabel.textColor = UIColor.lightGray
        titleLabel.text = "Add Pills"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Baskerville-Bold", size: 30)
        navigationItem.titleView = titleLabel
        
        // Register Cell
        self.registerCell()
        
        
    }
    
    //MARK:- TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Add Label if the table View is Empty
        if pillsArray.count == 0 {
            let homeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
            homeLabel.text = "Tap '+' to add Pill"
            homeLabel.textAlignment = NSTextAlignment.center
            tableView.backgroundView = homeLabel
            tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
            return 0
        } else {
            tableView.backgroundView = nil
            return pillsArray.count
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Create Cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderCell", for: indexPath) as? PillTableViewCell else {
            fatalError("Could not register cell with identifier ReminderCell")
        }
        
        let singlePill = pillsArray[indexPath.row]
        
        cell.pillNameCell.text = singlePill.pillName
        cell.instructionsCell.text = singlePill.pillInstruction
        cell.pillTimerCell.text = singlePill.pillStartTimer
        
        if let pillCountLabelText = singlePill.pillsCount {
            
            cell.pillsLeft.text = pillCountLabelText
            
        }
        
                //        cell.pillImageView.backgroundColor = singlePill.pillColor
        
        // Add color to pill taken img (ternary operation)
        
        cell.doneImageView.backgroundColor = singlePill.pillTaken ? .green : .red
        
        return cell
    }
    
    //MARK:- TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Delete pill from context and tableView
        //        context.delete(pillsArray[indexPath.row])
        //        pillsArray.remove(at: indexPath.row)
        
        // Toggle pill taken when selected
//        pillsArray[indexPath.row].pillTaken = !pillsArray[indexPath.row].pillTaken
        
        savePillsTaken()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    // Left Swipe Actions (Take and Edit)
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // Write action code for Take a Pill
        let pillTakenAction = UIContextualAction(style: .normal, title: "Done") { (UIContextualAction, UIView, boolValue) in
            
            // Toggle pill taken when selected
            self.pillsArray[indexPath.row].pillTaken = !self.pillsArray[indexPath.row].pillTaken
            
            // Update pill count on the cell
            guard let pillCountText = self.pillsArray[indexPath.row].pillsCount else {
                return
            }
            
            guard let selectedDosageText = self.pillsArray[indexPath.row].selectedDosage else {
                return
            }
            
            let pillCountInt = Int(pillCountText) ?? 0
            let selectedDosageInt = Int(selectedDosageText) ?? 0
            
            if pillCountInt > 0 {
                self.pillsArray[indexPath.row].pillsCount = String(pillCountInt - selectedDosageInt)
            }
            
            self.savePillsTaken()
            
            boolValue(true)
            
        }
        
        pillTakenAction.backgroundColor = .green
        
        let editPillAction = UIContextualAction(style: .normal, title: "Edit") { (UIContextualAction, UIView, boolValue) in
            print("Edit pill")
            boolValue(true)
        }
        editPillAction.backgroundColor = .gray
        
        let actionSwipes = UISwipeActionsConfiguration(actions: [pillTakenAction, editPillAction])
        
        return actionSwipes
        
    }
    
    // Right Swipe Action
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // Write action code for deleting a Pill
        let trashAction = UIContextualAction(style: .normal, title: "Delete") { (UIContextualAction, UIView, boolValue) in
            
            // Delete Pill from context and tableView
            self.context.delete(self.pillsArray[indexPath.row])
            self.pillsArray.remove(at: indexPath.row)
            
            self.savePillsTaken()
            
            boolValue(true)
        }
        
        trashAction.backgroundColor = .red
        
        let actionSwipes = UISwipeActionsConfiguration(actions: [trashAction])
        
        return actionSwipes
        
    }
    
    
    //MARK:- PillCell own methods
    
    func registerCell() {
        let pillCell = UINib(nibName: "PillTableViewCell", bundle: nil)
        self.tableView.register(pillCell, forCellReuseIdentifier: "ReminderCell")
    }
    
    //MARK:- Actions and Segue Methods
    
    @IBAction func saveButtonPressed(segue: UIStoryboardSegue) {
        
        
    }
    
    
    func savePillsTaken() {
        do {
            try context.save()
        } catch {
            
            print("Error saving pillsTaken in context, \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    func loadPills() {
        let request : NSFetchRequest<Pill> = Pill.fetchRequest()
        do {
            pillsArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    
}

