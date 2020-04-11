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
    
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // All Pills array
    var pillsArray: [Pill] = []
    
    override func viewWillAppear(_ animated: Bool) {
        //reload table rows
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Find user directory path for Core Data
        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        print(dataFilePath)
        
        
        // Test Data
//        let pillOne = Pill()
//        pillOne.pillNames = "Advil"
//        pillOne.pillStartTimer = "2019"
//        pillsArray.append(pillOne)
//
//        let pillTwo = Pill()
//        pillTwo.pillNames = "panadol"
//        pillTwo.pillStartTimer = "2019"
//        pillsArray.append(pillTwo)
//
//        let pillThree = Pill()
//        pillThree.pillNames = "Jass pill"
//        pillThree.pillStartTimer = "2019"
//        pillsArray.append(pillThree)
//
//        let pillFour = Pill()
//        pillFour.pillNames = "Advil"
//        pillFour.pillStartTimer = "2019"
//        pillsArray.append(pillFour)
//
//        let pillFive = Pill()
//        pillFive.pillNames = "Advil"
//        pillFive.pillStartTimer = "2019"
//        pillsArray.append(pillFive)
//
//        let pillSix = Pill()
//        pillSix.pillNames = "Advil"
//        pillSix.pillStartTimer = "2019"
//        pillsArray.append(pillSix)
//
//        let pillSeven = Pill()
//        pillSeven.pillNames = "Advil"
//        pillSeven.pillStartTimer = "2019"
//        pillsArray.append(pillSeven)
//
//        let pillEight = Pill()
//        pillEight.pillNames = "Advil"
//        pillEight.pillStartTimer = "2019"
//        pillsArray.append(pillEight)
//
        

        // Load pillsArray
//        loadPills()
        
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
//        cell.pillImageView.backgroundColor = singlePill.pillColor
        
        // Add color to pill taken img (ternary operation)
        
        cell.doneImageView.backgroundColor = singlePill.pillTaken ? .green : .red
        
        return cell
    }
    
    //MARK:- TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Toggle pill taken when selected
        pillsArray[indexPath.row].pillTaken = !pillsArray[indexPath.row].pillTaken
        
//        savePillsTaken() 
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    //MARK:- PillCell own methods
    
    func registerCell() {
        let pillCell = UINib(nibName: "PillTableViewCell", bundle: nil)
        self.tableView.register(pillCell, forCellReuseIdentifier: "ReminderCell")
    }
    
    //MARK:- Actions and Segue Methods
    
    @IBAction func saveButtonPressed(segue: UIStoryboardSegue) {
       

    }

    
//    func savePillsTaken() {
//         // Save data to custom plist
//         let encoder = PropertyListEncoder()
//         do {
//             let data = try encoder.encode(pillsArray)
//             try data.write(to: dataFilePath!)
//
//         } catch {
//             print("Error encoding pills Array, \(error)")
//         }
//
//        // Force data source metheds to reload
//        tableView.reloadData()
//
//    }
    
//    func loadPills() {
//        if let data = try? Data(contentsOf: dataFilePath!) {
//            let decoder = PropertyListDecoder()
//            do {
//                pillsArray = try decoder.decode([Pill].self, from: data)
//            } catch {
//                print("Error decoding pills array \(error)")
//            }
//
//        }
//    }
    
    
}

