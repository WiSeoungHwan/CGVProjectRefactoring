//
//  NotLoginTableViewCell.swift
//  CGVProject
//
//  Created by Wi on 08/12/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import UIKit

class NotLoginTableViewCell: UITableViewCell {
    @IBOutlet weak var defualtImage: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        loginButton.layer.cornerRadius = 15
        defualtImage.tintColor = .lightGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func loginBtnDidTap(_ sender: UIButton) {
        MainViewController.showLoginPage()
    }
}
