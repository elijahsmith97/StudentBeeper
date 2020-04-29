//
//  PostCell.swift
//  Student Beeper
//
//  Created by Elijah Smith on 4/20/20.
//  Copyright © 2020 Elijah Smith. All rights reserved.
//

import Foundation
import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var capacityLabel: UILabel!
    @IBOutlet weak var vehicleTypeLabel: UILabel!
    @IBOutlet weak var timeConstraintLabel: UILabel!
    
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
