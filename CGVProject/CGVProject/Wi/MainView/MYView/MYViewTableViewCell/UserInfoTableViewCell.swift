//
//  UserInfoTableViewCell.swift
//  CGVProject
//
//  Created by Wi on 29/11/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import UIKit

class UserInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userNickName: UILabel!
    @IBOutlet weak var userID: UILabel!
    
    var model: User? {
        didSet{
            if UserManager.singleton.hasToken{
                guard let user = model else {return}
                self.userID.text = user.username
                if user.firstName == "", user.lastName == ""{
                    self.userNickName.text = "이름을 설정해주세요"
                }else{
                    self.userNickName.text = "\(user.firstName!) \(user.lastName!)"
                }
            }else{
                self.userNickName.text = "로그인 후 이용해주세요."
                self.userID.text = " "
            }
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configure()
        setUserInfo()
    }
    func setUserInfo() {
        KOSessionTask.userMeTask { [weak self] (error, userMe) in
            if let error = error {
                return print(error.localizedDescription)
            }
            
            guard let me = userMe,
                let nickname = me.nickname,
                let thumbnailImageLink = me.thumbnailImageURL else { return }
            print(me)
            
            self?.userNickName.text = nickname
            
            let imageLinks = [thumbnailImageLink]
            for url in imageLinks {
                URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                    if let error = error {
                        return print(error.localizedDescription)
                        
                    }
                    guard let data = data, let image = UIImage(data: data) else { return }
                    
                    DispatchQueue.main.async {
                        if url == thumbnailImageLink {
                            self?.userProfileImageView.image = image
                        }
                    }
                    
                }).resume()
            }
            
        }
    }
    
    

    func configure(){
        // MARK: userProfileImageView
        
        userProfileImageView.layer.cornerRadius = userProfileImageView.frame.width / 2
        userProfileImageView.layer.masksToBounds = true
        // MARK: userID
        userIDEncryption()
    }
    func userIDEncryption(){
        guard var id = userID.text else {return}
        id.remove(at: String.Index(encodedOffset: 2))
        id.append(Character("*"))
        userID.text = id
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
