//
//  NeedBeepViewController.swift
//  Student Beeper
//
//  Copyright © 2020 Elijah Smith. All rights reserved.
//

import UIKit
import FirebaseAuth
import Foundation
import Firebase

class NeedBeepViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostCell {
            cell.configureCell(post: posts[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    private var postsCollectionRef: CollectionReference!
    private var posts = [Post]()
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.tableView.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 600
        tableView.rowHeight = UITableView.automaticDimension
        
        postsCollectionRef = Firestore.firestore().collection("posts")
    }


    override func viewWillAppear(_ animated: Bool) {
        postsCollectionRef.order(by: "timePosted", descending: true).getDocuments { (snapshot, error) in
        if let err = error {
            debugPrint("Error fetching documents: \(err)")
        } else {
            guard let snap = snapshot else { return }
            for document in snap.documents {
                let data = document.data()
                let capacity = data["capacity"] as? String ?? "Anonymous"
                let vehicleType = data["vehicleType"] as? String ?? "Anonymous"
                let startTime = data["startTime"] as? String ?? "Anonymous"
                let endTime = data["endTime"] as? String ?? "Anonymous"
                let timeConstraint = startTime + " - " + endTime
                let email = data["email"] as? String ?? "Anonymous"
                let timePosted = data["timePosted"] as! String
                
                //let phoneNumber = data["email"] as? String ?? "Anonymous"
                
                let newPost = Post(capacity: capacity, vehicleType: vehicleType, timeConstraint: timeConstraint, email: email,
                                   timePosted: timePosted/*, phoneNumber: phoneNumber*/)
                
                self.posts.append(newPost)
            }
            
            self.tableView.reloadData()
            
          }
        }
    }
    

}


