//
//  ViewController.swift
//  Calorimetry Calculator
//
//  Created by Владислав Юрченко on 24.02.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var sexSegmentController: UISegmentedControl!
    @IBOutlet weak var WeightField: UITextField!
    @IBOutlet weak var HeightField: UITextField!
    @IBOutlet weak var AgeField: UITextField!
    @IBOutlet weak var ActivityField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureSexSegmentController ()
        
    }
    
    @IBAction func calculateDidTab(_ sender: Any) {
    }
    
    @IBAction func clearDidTab(_ sender: Any) {
    }
    
    
    func configureSexSegmentController () {
        sexSegmentController.removeAllSegments()
        sexSegmentController.insertSegment(withTitle: "Male", at: 0, animated: false)
        sexSegmentController.insertSegment(withTitle: "Female", at: 1, animated: false)
        sexSegmentController.selectedSegmentIndex = 0
    }
    
    
    func configureTextFields () {
        WeightField.delegate = self
        HeightField.delegate = self
        AgeField.delegate = self
        
    }
}
extension HomeViewController: UITextFieldDelegate {}
 
