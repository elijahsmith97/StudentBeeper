//
//  RegisterViewController.swift
//  Student Beeper
//
//  Created by Elijah Smith on 2/24/20.
//  Copyright © 2020 Elijah Smith. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class RegisterViewController: UIViewController {
    
    
    //Text Field Outlets
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var numberTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var headsUpLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpElements()
    }
    
    func setUpElements() {
        //this hides our Heads Up label until needed
        headsUpLabel.alpha = 0
    }
    
    
    // Check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message
    func validateFields() -> String? {
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || numberTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Hey! It looks like you didn't fill in all the boxes!"
        }
        
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            //password isn't secure enough
            return "Oh no... please try a more secure password."
        }
        
        return nil
    }
    
    //Register Action Button
    @IBAction func registerTapped(_ sender: Any) {
        
        //validate the fields
        let error = validateFields()
        
        if error != nil {
            //there is something wrong with the fields
            showError(error!)
        }
        else {
            //create clean versions of data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let phoneNumber = numberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            
            //create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                if err != nil {
                    // there was an error creating the user
                    self.showError("Error creating user")
                }
                else {
                    // user was created successfully. now store first and last name
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: [
                        "firstName":firstName,
                        "lastName":lastName,
                        "uid":result!.user.uid,
                        "phoneNumber":phoneNumber]) {
                            (error) in if error != nil {
                           //this error message can be removed in the future to avoid showing users such error message
                            self.showError("UID Error")
                        }
                    }
                    
                    //nav to home screen
                    self.transitionToHome()
                }
            }
        }
        
    }
    
    func showError(_ message:String) {
        
        headsUpLabel.text = message
        headsUpLabel.alpha = 1
    }
    
    func transitionToHome() {
        
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
    
}
