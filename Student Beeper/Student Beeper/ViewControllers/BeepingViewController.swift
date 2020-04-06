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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        
    }
    
    func setUpElements() {
        errorLabel.alpha = 0
    }
    
    func validateFields() -> String? {
        if beepingPosting.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in the box"
        }
        
        return nil
    }
    
    @IBOutlet weak var beepingPosting: UITextView!
    
    @IBAction func postButton(_ sender: Any) {
    }
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBAction func postTapped(_ sender: Any) {
        let error = validateFields()
        
        let postDescription = beepingPosting.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let db = Firestore.firestore()
        db.collection("posts")
            .addDocument(data: ["post_description":postDescription])
    }
    
    
}
