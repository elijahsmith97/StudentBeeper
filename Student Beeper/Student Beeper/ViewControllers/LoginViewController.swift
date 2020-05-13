//
//  LoginViewController.swift
//  
//
//  Created by Elijah Smith on 2/24/20.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var studentBeeperLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpElements()
    }
    
    func setUpElements() {
        //this hides the error label
        errorLabel.alpha = 0
    
    }
    
    // Check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message
    func validateFields() -> String? {
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill all boxes before continuing."
        }
        
        return nil
    }
    
    
    
    //Action buttons (tapped)
    @IBAction func loginTapped(_ sender: Any) {
       
        //validate the fields
        let error = validateFields()
        
        if error != nil {
            //there is something wrong with the fields
            showError(error!)
        }
        else {
            //create clean versions of data

            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                
            //log the user in
            Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
                if err != nil {
                    // there was an error signing the user in
                    self.showError("Try your password/email combo again.")
                }
                else {
                    //nav to home screen
                    self.transitionToHome()
                }
            }
        }
    }
    
    @IBAction func registerTapped(_ sender: Any) {
    }
        
    func showError(_ message:String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome() {
            
        let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
            
        self.view.window?.rootViewController = homeViewController
        self.view.window?.makeKeyAndVisible()
            
        }
}
