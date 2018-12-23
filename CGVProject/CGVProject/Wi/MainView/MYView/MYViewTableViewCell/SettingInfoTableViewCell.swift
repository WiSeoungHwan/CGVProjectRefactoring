//
//  InfoTableViewCell.swift
//  CGVProject
//
//  Created by Wi on 30/11/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import UIKit
protocol SettingInfoTableViewCellDelegate {
    func logoutDidTap()
}

class SettingInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var infoTableView: UITableView!
    private let buttonNames = ["예매내역","결제내역조회","개인정보관리","공지사항","로그아웃"]
    var delegate: SettingInfoTableViewCellDelegate?
    var user: User?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        infoTableView.dataSource = self
        infoTableView.delegate = self
        infoTableView.register(UINib(nibName: "DefaultInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "DefaultInfo")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension SettingInfoTableViewCell: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buttonNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultInfo", for: indexPath)
        cell.textLabel?.text = buttonNames[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    
}
extension SettingInfoTableViewCell: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print("예매내역 클릭")
            MainViewController.showReservationPage()
        case 1:
            print("결제내역조회 클릭")
        case 2:
            print("개인정보관리 클릭")
            MainViewController.showPersonalInfoSetting(user: self.user)
        case 3:
            print("공지사항 클릭")
        case 4:
            print("로그아웃 클릭")
            UserManager.singleton.signOut(completion: {
                self.delegate?.logoutDidTap()
            })
        default:
            break
        }
    }

}
