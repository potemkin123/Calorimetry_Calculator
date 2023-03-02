//
//  ViewController.swift
//  Calorimetry Calculator
//
//  Created by Владислав Юрченко on 24.02.2023.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var sexSegmentControl: UISegmentedControl!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var activityField: UITextField!
    @IBOutlet weak var canculateButton: UIButton!
    
    
    let pickerView = UIPickerView()
    let activities = ["None", "Low", "Medium", "High"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSexSegmentControl()
        configureTextFields()
        configureActivityField()
        
        weightField.becomeFirstResponder()
        
    }
    
    
        
        func calculateDidTab(_ sender: Any) {
            let weight = Int(weightField.text ?? "") ?? 0
            let height = Int(heightField.text ?? "") ?? 0
            let age = Int(ageField.text ?? "") ?? 0
            
            let activityIndex = pickerView.selectedRow(inComponent: 0)
            let activity = activities[activityIndex]
            
            var activityValue = 0
            switch activity {
            case "None": activityValue = 0
            case "Low": activityValue = 50
            case "Medium": activityValue = 150
            case "High": activityValue = 200
            default: break
            }
            
            let selectedSex = sexSegmentControl.selectedSegmentIndex
            var result = ""
            switch selectedSex {
            case 0:
                let result = 10 * weight +
                6.25 * height - 5 * age
                + 5 + activityValue
                showAlertWith(result)
                
            case 1:
                let result = 8 * weight + 5.25 * height - 5 * age + 5 - 161 + activityValue
                showAlertWith(result)
                
            default: break
            }
        }
        func showAlertWith(title: String) {
            let alert = UIAlertController (title: "Your result", message: self, preferredStyle: .alert))
            alert.addAction(.init(title: "Ok", style: cancel))
            
            @IBAction func sexControlDidChange(_ sender: UISegmentedControl){
                //        switch sender.selectedSegmentIndex {
                //        case 0:
                //            break
                //        case 1:
                //            break
                //        default: break
                //        }
                clear ()
            }
            func clearDidTab(_ sender: Any) {
                clear ()
            }
            func clear () {
                weightField.text = nil
                heightField.text = nil
                ageField.text = nil
                pickerView.selectRow(0, inComponent: 0, animated: true)
                selectActivityBy(row: 0)
                weightField.becomeFirstResponder()
            }
            
            func configureSexSegmentControl () {
                sexSegmentControl.removeAllSegments()
                sexSegmentControl.insertSegment(withTitle: "Male", at: 0, animated: false)
                sexSegmentControl.insertSegment(withTitle: "Female", at: 1, animated: false)
                sexSegmentControl.selectedSegmentIndex = 0
            }
            
            
            func configureTextFields () {
                weightField.delegate = self
                weightField.keyboardType = .numberPad
                
                heightField.delegate = self
                heightField.keyboardType = .numberPad
                
                ageField.delegate = self
                ageField.keyboardType = .numberPad
                
            }
            
            func configureActivityField() {
                pickerView.dataSource = self
                pickerView.delegate = self
                activityField.inputView = pickerView
                selectActivityBy(row: 0)
            }
            func selectActivityBy(row: Int) {
                activityField.text = activities[row]
            }
        }
        
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return activities[row]
        }
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            selectActivityBy(row: row)
        }
    }
}
extension HomeViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}
extension HomeViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return activities.count
    }
