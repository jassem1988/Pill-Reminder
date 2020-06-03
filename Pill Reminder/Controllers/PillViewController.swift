//
//  PillViewController.swift
//  Pill Reminder
//
//  Created by Jassem Al-Buloushi on 3/4/20.
//  Copyright © 2020 Jassem Al-Buloushi. All rights reserved.
//

import UIKit
import CoreData
import NotificationCenter

class PillViewController: UITableViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK:- Outlets
    
    @IBOutlet var saveButtonOutlet: UIBarButtonItem!
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var doseTextField: UITextField!
    @IBOutlet var typeTextField: UITextField!
    @IBOutlet var instructionsTextField: UITextField!
    @IBOutlet var startDateTextField: UITextField!
    @IBOutlet var intakeTextField: UITextField!
    @IBOutlet var colorOrImageTextField: UITextField!
    @IBOutlet var pillsCountTextField: UITextField!
    
    
    //MARK:- Properties
    
    
    
    // Selected options
    var selectedPillType: String?
    var selectedIntake: String?
    
    var userSelectedTimeStart: String?
    var userSelectedDateStart: String?
    var pillsCount: String?
    
    var selectedNotificationDate: Date?
    
    // Static options
    var pillTypes = ["Taps", "Pills", "g", "mg", "mcg"]
    var intake = ["1 Times a Day", "2 Times a Day", "3 Times a Day", "4 Times a Day"]
    var pillColors : [(colorName: String, color: UIColor)] = [("Red", .red), ("Orange", .orange), ("Magenta", .magenta)]
    
    // Create a new pill NSManagedObject
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var datePicker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the interface color of User
        overrideUserInterfaceStyle = .light
        
        // Check if Required TextFields are not Empty
        checkIfTextFieldIsNotEmpty()
        
        // Create PickerViews for a textField
        createPickerView(for: [typeTextField, intakeTextField, colorOrImageTextField])
        
        // Create datePickerView for a textField
        createDatePicker(for: startDateTextField)
        
        // Add toolbar to textFields
        dissmissPickerView(for: [typeTextField, intakeTextField, colorOrImageTextField, startDateTextField, nameTextField, instructionsTextField, pillsCountTextField])
        
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK:- UIPickerView data source and delegate methods
    
    // Number of sections
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Number of dropdown items
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if typeTextField.isFirstResponder {
            return pillTypes.count
        } else if intakeTextField.isFirstResponder {
            return intake.count
        } else if colorOrImageTextField.isFirstResponder {
            return pillColors.count
        }
        return 1
    }
    
    // Dropdown items
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if typeTextField.isFirstResponder {
            return pillTypes[row]
        } else if intakeTextField.isFirstResponder {
            return intake[row]
        } else if colorOrImageTextField.isFirstResponder {
            return pillColors[row].colorName
        }
        return ""
    }
    
    // Selected item
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if typeTextField.isFirstResponder {
            selectedPillType = pillTypes[row]
            typeTextField.text = selectedPillType
        } else if intakeTextField.isFirstResponder {
            selectedIntake = intake[row]
            intakeTextField.text = selectedIntake
        } else if colorOrImageTextField.isFirstResponder {
            //            pill.selectedColorString = Pill.pillColors[row].colorName
            //            pill.selectedColor = Pill.pillColors[row].color
            //
            //            colorOrImageTextField.text = pill.selectedColorString
            //            colorOrImageTextField.textColor = pill.selectedColor
        }
    }
    
    //MARK:- PickerView own methods
    
    func createPickerView(for textFields: [UITextField]) {
        
        for textField in textFields {
            let pickerView = UIPickerView()
            pickerView.delegate = self
            textField.inputView = pickerView
        }
    }
    
    func dissmissPickerView(for textFields: [UITextField]) {
        let toolBar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        
        for textField in textFields {
            textField.inputAccessoryView = toolBar
        }
    }
    
    @objc func action() {
        view.endEditing(true)
    }
    
    //MARK:- Own DatePickerView methods
    
    func createDatePicker(for textField: UITextField) {
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .dateAndTime
        let minDatePicker = Date()
        datePicker?.minimumDate = minDatePicker
        textField.inputView = datePicker
        datePicker?.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        
        // Format date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy, h:mm a"
        
        if startDateTextField.isFirstResponder {
            
            self.startDateTextField.text = dateFormatter.string(from: datePicker.date)
            
            guard let startTimeText = self.startDateTextField.text else { return }
            
            // Create notification Date
            selectedNotificationDate = dateFormatter.date(from: startTimeText)
            
            // Create time and date substring
            userSelectedTimeStart = self.createSubstring(for: startTimeText).time
            userSelectedDateStart = self.createSubstring(for: startTimeText).date
            
            
        }
        
    }
    
    //MARK:- My own methods
    
    func checkIfTextFieldIsNotEmpty() {
        saveButtonOutlet.isEnabled = false
        nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        doseTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        startDateTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        
        tableView.reloadData()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let nameText = nameTextField.text, let dosageText = doseTextField.text, let startDateText = startDateTextField.text else { return }
        if !nameText.isEmpty && !dosageText.isEmpty && !startDateText.isEmpty {
            saveButtonOutlet.isEnabled = true
        } else {
            saveButtonOutlet.isEnabled = false
        }
    }
    
    func createSubstring(for dateFullString: String) -> (time: String, date: String) {
        let timeString = String(dateFullString.suffix(8))
        let dateString = String(dateFullString.prefix(12))
        
        return (timeString, dateString)
    }
    
    //MARK:- Segue Actions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        let pill = Pill(context: context)
        
        // Set pill taken
        pill.pillTaken = false
        let uuidString = UUID()
        pill.uuiString = uuidString
        
        pill.selectedNotificationDate = selectedNotificationDate
        
        pill.selectedPillType = selectedPillType
        pill.selectedIntake = selectedIntake
        pill.userSelectedTimeStart = userSelectedTimeStart
        pill.userSelectedDateStart = userSelectedDateStart
        
        if let destVC = segue.destination as? HomeViewController {
            
            // Send pill names to HomeVC
            guard let nameText = nameTextField.text else { return }
            pill.pillName = nameText
            
            // Send pill info to HomeVC
            guard let infoText = instructionsTextField.text else { return }
            pill.pillInstruction = infoText
            
            // Send pill timer to HomeVC
            guard let userTimerStart = startDateTextField.text else { return }
            pill.pillStartTimer = userTimerStart
            
            // Send pill dosage to HomeVc
            guard let doseTextFieldText = doseTextField.text else { return }
            pill.selectedDosage = doseTextFieldText
            
            // Send pill count to HomeVC
            guard let pillCountText = pillsCountTextField.text else { return }
            pill.pillsCount = pillCountText
            
            // Send pill color to HomeVC
            //            guard let pillColor = colorOrImageTextField.textColor else { return }
            //            pill.pillColor = pillColor
            
            // Create Notification
            createNotification(pill: pill)
            
            // Append new pill to pill array
            destVC.pillsArray.append(pill)
            
            // Save pills in custom plist
            savePills()
            
        }
        
    }
    
    //MARK:- Model Manupulation Methods
    
    func savePills() {
        //Save data to Core Data
        
        do {
            try context.save()
            
        } catch {
            print("Error Saving context, \(error)")
        }
    }
    
    func createNotification (pill: Pill) {
        
        // Ask for permistion for local notification
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                print("notification granted!")
            } else {
                print("notification was denied!")
            }
        }
        
        // Create the notification content
        let content = UNMutableNotificationContent()
        
        // Create notification title, body and info
        guard let pillNameString = pill.pillName else { return }
        content.title = pillNameString
        guard let pillInstructionString = pill.pillInstruction else { return }
        content.body = pillInstructionString
        content.sound = .default
        
        // Create notification trigger
        guard let selectedDate = pill.selectedNotificationDate else { return }
        
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: selectedDate)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        // Create the request
        guard let uuidstr = pill.uuiString?.uuidString else { return }
        
        let request = UNNotificationRequest(identifier: uuidstr, content: content, trigger: trigger)
        
        // Register the request
        center.add(request) { (error) in
            // Handle error
            if error != nil {
                print("Failed to add notification request, \(error!)")
            }
        }
        
    }
    
}
