//
//  ActivitiesListViewController.swift
//  Calorimetry Calculator
//
//  Created by Владислав Юрченко on 03.03.2023.
//

import UIKit

class ActivitiesListViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    var activity: Activity?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let activity = activity {
            label.text = "Activity: \(activity.title) with \(activity.value) calories"
        } else  {
            label.text = "No selected activity"
            // Do any additional setup after loading the view.
        }
    }
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

