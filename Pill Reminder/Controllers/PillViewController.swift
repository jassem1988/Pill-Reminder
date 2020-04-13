//
//  PillViewController.swift
//  Pill Reminder
//
//  Created by Jassem Al-Buloushi on 3/4/20.
//  Copyright © 2020 Jassem Al-Buloushi. All rights reserved.
//

import UIKit
import CoreData

class PillViewController: UITableViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK:- Outlets
    
    @IBOutlet var saveButtonOutlet: UIBarButtonItem!
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var doseTextField: UITextField!
    @IBOutlet var typeTextField: UITextField!
    @IBOutlet var instructionsTextField: UITextField!
    @IBOutlet var startDateTextField: UITextField!
    @IBOutlet var endDateTextField: UITextField!
    @IBOutlet var intakeTextField: UITextField!
    @IBOutlet var colorOrImageTextField: UITextField!
    
    
    //MARK:- Properties
    
    // Selected options
    var selectedPillType: String?
    var selectedIntake: String?
    
    var userSelectedTimeStart: String?
    var userSelectedDateStart: String?
    var userSelectedTimeEnd: String?
    var userSelectedDateEnd: String?
     
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
        createPickerView(for: typeTextField)
        createPickerView(for: intakeTextField)
        createPickerView(for: colorOrImageTextField)
        
        // Create datePickerView for a textField
        createDatePicker(for: startDateTextField)
        createDatePicker(for: endDateTextField)
        
        // Add toolbar to textFields
        dissmissPickerView(for: typeTextField)
        dissmissPickerView(for: intakeTextField)
        dissmissPickerView(for: colorOrImageTextField)
        
        dissmissPickerView(for: startDateTextField)
        dissmissPickerView(for: endDateTextField)
        
        // Add keyboard done button
        addDoneButtonOnKeyboard(for: nameTextField)
        addDoneButtonOnKeyboard(for: doseTextField)
        addDoneButtonOnKeyboard(for: instructionsTextField)
        
        
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
    
    func createPickerView(for textField: UITextField) {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        textField.inputView = pickerView
    }
    
    func dissmissPickerView(for textField: UITextField) {
        let toolBar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }
    
    @objc func action() {
        view.endEditing(true)
    }
    
    //MARK:- Own DatePickerView methods
    
    func createDatePicker(for textField: UITextField) {
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .dateAndTime
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
            
            // Create time and date substring
            userSelectedTimeStart = self.createSubstring(for: startTimeText).time
            userSelectedDateStart = self.createSubstring(for: startTimeText).date
            
        } else if endDateTextField.isFirstResponder {
            self.endDateTextField.text = dateFormatter.string(from: datePicker.date)
            
            guard let endTimeText = self.endDateTextField.text else { return }
            
            // Create time and date substring
            userSelectedTimeEnd = self.createSubstring(for: endTimeText).time
            userSelectedDateEnd = self.createSubstring(for: endTimeText).date
        }
        
    }
    
    //MARK: - Add Keyboard Actions
    
    // Add Done button to the keyboard
    func addDoneButtonOnKeyboard(for textField: UITextField) {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        
        doneToolbar.barStyle = UIBarStyle.default
        
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(done)
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        textField.inputAccessoryView = doneToolbar
    }
    
    // Dismiss Keyboard when Done button pressed
    @objc func doneButtonAction() {
        nameTextField.resignFirstResponder()
        doseTextField.resignFirstResponder()
        instructionsTextField.resignFirstResponder()
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
        
        pill.selectedPillType = selectedPillType
        pill.selectedIntake = selectedIntake
        pill.userSelectedTimeStart = userSelectedTimeStart
        pill.userSelectedDateStart = userSelectedDateStart
        pill.userSelectedTimeEnd = userSelectedTimeEnd
        pill.userSelectedDateEnd = userSelectedDateEnd
        
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
            
            // Send pill color to HomeVC
            //            guard let pillColor = colorOrImageTextField.textColor else { return }
            //            pill.pillColor = pillColor
            
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
    
}
