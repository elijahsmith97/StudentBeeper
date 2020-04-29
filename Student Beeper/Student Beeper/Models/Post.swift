//
//  Post.swift
//  Student Beeper
//
//  Created by Elijah Smith on 4/20/20.
//  Copyright © 2020 Elijah Smith. All rights reserved.
//

import Foundation
class Post {
    
    var capacityText: String
    var vehicleTypeText: String
    var timeConstraintText: String
    var emailText: String
    
    init(capacity: String, vehicleType: String, timeConstraint: String, email: String) {
        capacityText = capacity
        vehicleTypeText = vehicleType
        timeConstraintText = timeConstraint
        emailText = email
    }
}
