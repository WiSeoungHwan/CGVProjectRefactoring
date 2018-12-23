//
//  LoginTableViewCell.swift
//  CGVProject
//
//  Created by Wi on 08/12/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import UIKit

class LoginTableViewCell: UITableViewCell {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usetNickName: UILabel!
    @IBOutlet weak var howMuchwatchedMovie: UILabel!
    var model: User? {
        didSet{
            if UserManager.singleton.hasToken{
                guard let user = model else {return}
                if user.firstName == "", user.lastName == ""{
                    self.usetNickName.text = "이름을 설정해주세요."
                }else{
                    self.usetNickName.text = "\(user.firstName!) \(user.lastName!)"
                }
            }else{
                self.usetNickName.text = "로그인 후 이용해주세요."
            }
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        userImageView.tintColor = .lightGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    
}
