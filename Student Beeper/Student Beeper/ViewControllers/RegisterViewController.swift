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
    
    @IBOutlet weak var studentBeeperLabel: UILabel!
    
    //Text Field Outlets
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordLabel: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var headsUpLabel: UILabel!
    @IBOutlet weak var goBackButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpElements()
    }
    
    func setUpElements() {
        //this hides our Heads Up label until needed
        headsUpLabel.alpha = 0
        //this hides our Continue Anyways button until needed
        continueButton.alpha = 0
    }
    
    
    // Check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message
    func validateFields() -> String? {
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || numberTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Please fill all boxes before continuing."
        }
        
        let cleanedEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedConfirmPassword = confirmPasswordLabel.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            //password isn't secure enough
            return "Please try a more secure password."
        }
        
        if (cleanedPassword != cleanedConfirmPassword) {
            // password and confirm password does not match
            return "Passwords are not the same."
        }
        
        if Utilities.isStudentEmailValid(cleanedEmail) == false {
            //email isn't a valid student email
            continueButton.alpha = 1
            return "No student email?"
        }
        
        return nil
    }
    
    // Register Action Button
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
            let cleanedNumber = numberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let formattedNumber = Utilities.formattedNumber(cleanedNumber)
            
            // create the user
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
                        "phoneNumber":formattedNumber]) {
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
    
    // "Continue Anyways" button pressed
    @IBAction func continueTapped(_ sender: Any) {
       //create clean versions of data
       let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
       let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
       let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
       let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
       let cleanedNumber = numberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
       let formattedNumber = Utilities.formattedNumber(cleanedNumber)
       
       // create the user
       Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
           if err != nil {
               // there was an error creating the user
               self.showError("Something went wrong... Try again later")
           }
           else {
               // user was created successfully. now store first and last name
               let db = Firestore.firestore()
               db.collection("users").addDocument(data: [
                   "firstName":firstName,
                   "lastName":lastName,
                   "uid":result!.user.uid,
                   "phoneNumber":formattedNumber]) {
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
