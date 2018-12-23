//
//  StartViewController.swift
//  CGVProject
//
//  Created by PigFactory on 30/11/2018.
//  Copyright © 2018 PigFactory. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.layer.cornerRadius = startButton.frame.height / 2
    }

}
