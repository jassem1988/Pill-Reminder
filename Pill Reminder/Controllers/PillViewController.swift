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
    
    //MARK:- Properties
    
    var selectedPillType: String?
    var pillTypes = ["Taps", "Pills", "g", "mg", "mcg"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createPickerView()
        dissmissPickerView()
        
    }
    
    //MARK:- UIPickerView data source and delegate methods
    
    // Number of sections
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Number of dropdown items
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pillTypes.count
    }
    
    // Dropdown item
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pillTypes[row]
    }
    
    // Selected item
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPillType = pillTypes[row]
        typeTextField.text = selectedPillType
    }
    
    //MARK:- PickerView own methods
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        typeTextField.inputView = pickerView
    }
    
    func dissmissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "done", style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        typeTextField.inputAccessoryView = toolBar
    }
    
    @objc func action() {
        view.endEditing(true)
    }

    
}
