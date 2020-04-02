//
//  HomeViewController.swift
//  Student Beeper
//
//  Created by Elijah Smith on 2/24/20.
//  Copyright © 2020 Elijah Smith. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBOutlet weak var studentBeeperLabel: UILabel!
    
    @IBAction func beepingButton(_ sender: Any) {
    }
    @IBOutlet weak var beepingLabel: UILabel!
    
    @IBAction func needBeepButton(_ sender: Any) {
    }
    
    @IBOutlet weak var needBeepLabel: UILabel!
    
}
