//
//  PillViewController.swift
//  Pill Reminder
//
//  Created by Jassem Al-Buloushi on 3/4/20.
//  Copyright © 2020 Jassem Al-Buloushi. All rights reserved.
//

import UIKit

class PillViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK:- Outlets
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var doseTextField: UITextField!
    @IBOutlet var typeTextField: UITextField!
    @IBOutlet var instructionsTextField: UITextField!
    @IBOutlet var startDateTextField: UITextField!
    @IBOutlet var endDateTextField: UITextField!
    @IBOutlet var intakeTextField: UITextField!
    
    
    //MARK:- Properties
    private var datePicker: UIDatePicker?
    
    var selectedPillType: String?
    var selectedIntake: String?
    var pillNames = [String]()
    var pillTypes = ["Taps", "Pills", "g", "mg", "mcg"]
    var intake = ["1 Times a Day", "2 Times a Day", "3 Times a Day", "4 Times a Day"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create PickerViews for a textField
        createPickerView(for: typeTextField)
        createPickerView(for: intakeTextField)
        
        // Create datePickerView for a textField
        createDatePicker(for: startDateTextField)
        createDatePicker(for: endDateTextField)
        
        // Add toolbar to textFields
        dissmissPickerView(for: typeTextField)
        dissmissPickerView(for: intakeTextField)
        
        dissmissPickerView(for: startDateTextField)
        dissmissPickerView(for: endDateTextField)
        
        // Add keyboard done button
        addDoneButtonOnKeyboard(for: nameTextField)
        addDoneButtonOnKeyboard(for: instructionsTextField)
        
        
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
        }
        
        return 1
        
    }
    
    // Dropdown items
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if typeTextField.isFirstResponder {
            return pillTypes[row]
        } else if intakeTextField.isFirstResponder {
            return intake[row]
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
        }
    }
    
    //MARK:- PickerView own methods
    
    func createPickerView(for textField: UITextField) {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        textField.inputView = pickerView
    }
    
    func dissmissPickerView(for textField: UITextField) {
        let toolBar = UIToolbar()
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
        //Format date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy, h:mm a"
        
        if startDateTextField.isFirstResponder {
            self.startDateTextField.text = dateFormatter.string(from: datePicker.date)
        } else if endDateTextField.isFirstResponder {
            self.endDateTextField.text = dateFormatter.string(from: datePicker.date)
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
        instructionsTextField.resignFirstResponder()
    }
    
    
    //MARK:- My own methods
    
    
    
    //MARK:- Button Actions
    
    @IBAction func sendReminderButtonPressed(_ sender: UIButton) {
        
        
        
    }
    
    
    
}
