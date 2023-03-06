//
//  ViewController.swift
//  Calorimetry Calculator
//
//  Created by Владислав Юрченко on 24.02.2023.
//

import UIKit
import Foundation

class HomeViewController: UIViewController {
    
    @IBOutlet weak var sexSegmentControl: UISegmentedControl!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var activityField: UITextField!
    @IBOutlet weak var canculateButton: UIButton!
    let pickerView = UIPickerView()
    let activities = Activity.allCases
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Calculator"
        configureSexSegmentControl()
        configureTextFields()
        configureActivityField()
        weightField.becomeFirstResponder()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "activitySegue" {
            if let activityController = segue.destination as? ActivitiesListViewController {
                let activityIndex = pickerView.selectedRow(inComponent: 0)
                let activity = activities[activityIndex]
                activityController.activity = activity
            }
        }
    }
    @IBAction func calculateDidTab(_ sender: Any) {
        guard let weight = Int(weightField.text ?? ""),
              let height = Int(heightField.text ?? ""),
              let age = Int(ageField.text ?? ""),
              weight > 0 && height > 0 && age > 0 else {
            return
        }
        let activityIndex = pickerView.selectedRow(inComponent: 0)
        let activity = activities[activityIndex]
        let activityValue = activity.value
        
        
        guard let seletedSex = Sex(rawValue: sexSegmentControl.selectedSegmentIndex) else {return}
        
        switch seletedSex {
        case .male:
            let result = Double (10 * weight) +
            (6.25 * Double (height)) - Double (5 * age)
            + 5.0 + Double (activityValue)
            showAlertWith(title: String (result))
            
        case .female:
            let result = Double (8 * weight) +
            (5.25 * Double (height)) - Double (5 * age)
            + 5.0 - 161.0 + Double (activityValue)
            showAlertWith(title: String (result))

        }
    }
    
    func showAlertWith(title: String) {
        let alert = UIAlertController (title: "Your result", message: title, preferredStyle: .alert)
        alert.addAction(.init(title: "Ok", style: .cancel))
        alert.addAction(.init(title: "Activity detail info", style: .default) { _ in
            self.performSegue(withIdentifier: "activitySegue", sender: self)
        })
        self.present(alert, animated: true)
    }
               
    @IBAction func sexControlDidCange(_ sender: UISegmentedControl) {
    clear ()
    }
            
    @IBAction func sexControlDidTab(_ sender: Any) {
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
                sexSegmentControl.insertSegment(withTitle: Sex.male.title, at: 0, animated: false)
                sexSegmentControl.insertSegment(withTitle: Sex.female.title, at: 1, animated: false)
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
                activityField.text = activities[row].title
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
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return activities[row].title
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectActivityBy(row: row)
    }
}

