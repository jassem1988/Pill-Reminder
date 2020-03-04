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

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK:- TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderCell", for: indexPath)
        
        cell.textLabel?.text = String(items[indexPath.row])
        
        return cell
    }
    
    


}

