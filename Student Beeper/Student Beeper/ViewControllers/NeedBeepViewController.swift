//
//  NeedBeepViewController.swift
//  Student Beeper
//
//  Created by Elijah Smith on 4/2/20.
//  Copyright © 2020 Elijah Smith. All rights reserved.
//

import UIKit
import FirebaseAuth
import Foundation
import Firebase

class NeedBeepViewController: UIViewController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        showPostings()
    }

    @IBOutlet weak var postsTable: UITableView!
    
    func showPostings() {
        let db = Firestore.firestore()
        
        db.collection("posts").getDocuments { (snapshot, error) in
            
            if error == nil && snapshot != nil {
                
                for document in snapshot!.documents {
    
                    let postDescription = document.data()
                    
                
                }
            }
        }

        
    }
}
