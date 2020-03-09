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
    
    var selectedPillType: String?
    var selectedIntake: String?
    var pillNames = [String]()
    var pillTypes = ["Taps", "Pills", "g", "mg", "mcg"]
    var intake = ["1 Times a Day", "2 Times a Day", "3 Times a Day", "4 Times a Day"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pickerView1 = createPickerView(textField: typeTextField, tag: 0)
        let pickerView2 = createPickerView(textField: intakeTextField, tag: 1)
        
        dissmissPickerView(textField: typeTextField)
        dissmissPickerView(textField: intakeTextField)
        
    }
    
    //MARK:- UIPickerView data source and delegate methods
    
    // Number of sections
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Number of dropdown items
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return pillTypes.count
        } else if pickerView.tag == 1 {
            return intake.count
        }
        
        return 1
        
    }
    
    // Dropdown item
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            return pillTypes[row]
        } else if pickerView.tag == 1 {
            return intake[row]
        }
        
        return ""
    }
    
    // Selected item
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            selectedPillType = pillTypes[row]
            typeTextField.text = selectedPillType
        } else if pickerView.tag == 1 {
            selectedIntake = intake[row]
            intakeTextField.text = selectedIntake
        }
        
        
    }
    
    //MARK:- PickerView own methods
    
    func createPickerView(textField: UITextField, tag: Int) -> UIPickerView {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        textField.inputView = pickerView
        pickerView.tag = tag
        return pickerView
    }
    
    func dissmissPickerView(textField: UITextField) {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "done", style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }
    
    @objc func action() {
        view.endEditing(true)
    }
    
    //MARK:- My own methods
    
    
    
    //MARK:- Button Actions
    
    @IBAction func sendReminderButtonPressed(_ sender: UIButton) {
        
        
        
    }
    
    
    
}
