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
 
    var postsArray = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        showPostings()
    }

    @IBOutlet weak var tableView: UITableView!
    
    func showPostings() {
        let db = Firestore.firestore()
        
        db.collection("posts").getDocuments { (snapshot, error) in
            
            if error == nil && snapshot != nil {
                
                for document in snapshot!.documents {
                    
                    let postDescription = document.data()
                    self.postsArray.append(postDescription)
                    
                }
            }
            print(self.postsArray) //prints data from db
            self.tableView.reloadData()
        }
        
    }
}
    
extension NeedBeepViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.postsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = postsArray[indexPath.row] as? String
        return cell
    }
}

