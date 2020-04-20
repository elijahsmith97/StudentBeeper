//
//  BeepingViewController.swift
//  
//
//  Created by Elijah Smith on 4/2/20.
//

import UIKit
import Foundation
import FirebaseAuth
import Firebase

class BeepingViewController: UIViewController {
    
    @IBOutlet weak var postButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var beepingPageLabel: UILabel!
    
    @IBOutlet weak var vehicleTypeTextField: UITextField!
    
    @IBOutlet weak var capacityTextField: UITextField!
    
    @IBOutlet weak var timeConstraintTextField: UITextField!
    
    @IBOutlet weak var successLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
        
    }
    
    func setUpElements() {
        errorLabel.alpha = 0
        successLabel.alpha = 0
    }
    
    func validateFields() -> String? {
        let capacity = capacityTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let vehicle = vehicleTypeTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let timeConstraint = timeConstraintTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if capacity == "" || vehicle == "" || timeConstraint == "" {
            return "Please fill in all the boxes"
        }
        
        return nil
    }
    
    @IBAction func postTapped(_ sender: Any) {
        let error = validateFields()
        
        if error != nil {
            showError(error!)
        }
        let capacity = capacityTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let vehicle = vehicleTypeTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let timeConstraint = timeConstraintTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let db = Firestore.firestore()
        db.collection("posts")
            .addDocument(data: ["capacity":capacity,
                                "vehicleType":vehicle,
                                "timeConstraint":timeConstraint])
        clearText()
        showSuccess()
                                    
    }
    
    func showError(_ message:String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func clearText() {
        capacityTextField.text = ""
        vehicleTypeTextField.text = ""
        timeConstraintTextField.text = ""
    }
    
    func showSuccess() {
        successLabel.alpha = 1
    }
    
}
