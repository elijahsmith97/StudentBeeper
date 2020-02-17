//
//  Data.swift
//  Student Beeper
//
//  Created by Elijah Smith on 2/11/20.
//  Copyright © 2020 Elijah Smith. All rights reserved.
//

import SwiftUI


let beepers = [Beeper(id: 1, name: "Elijah Smith"),
               Beeper(id: 2, name: "Jesse Monroy"),
               Beeper(id: 3, name: "Chris Chanclor"),
               Beeper(id: 4, name: "Jon Spencer")]

struct Beeper : Identifiable{
    var id:Int
    var name:String
}
