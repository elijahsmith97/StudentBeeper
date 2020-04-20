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

class NeedBeepViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostCell {
            cell.configureCell(post: posts[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var capacityLabel: UILabel!
    
    @IBOutlet weak var vehicleTypeLabel: UILabel!
    
    @IBOutlet weak var timeConstraintLabel: UILabel!
    
    
    private var postsCollectionRef: CollectionReference!
    private var posts = [Post]()
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        
        postsCollectionRef = Firestore.firestore().collection("posts")
    }


    func showPostings() {
        postsCollectionRef.getDocuments { (snapshot, error) in
        if let err = error {
            debugPrint("Error fetching documents: \(err)")
        } else {
            guard let snap = snapshot else { return }
            for document in snap.documents {
                let data = document.data()
                let capacity = data["capacity"] as? String ?? "Anonymous"
                let vehicleType = data["vehicleType"] as? String ?? "Anonymous"
                let timeConstraint = data["timeConstraint"] as? String ?? "Anonymous"
                let email = data["email"] as? String ?? "Anonymous"
                
                let newPost = Post(capacity: capacity, vehicleType: vehicleType, timeConstraint: timeConstraint, email: email)
                
                self.posts.append(newPost)
            }
            
            self.tableView.reloadData()
            
          }
        }
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
        //init code
    }
    
    func configureCell(post: Post) {
        emailLabel.text = post.emailText
        capacityLabel.text = post.capacityText
        vehicleTypeLabel.text = post.vehicleTypeText
        timeConstraintLabel.text = post.timeConstraintText
    }
}


