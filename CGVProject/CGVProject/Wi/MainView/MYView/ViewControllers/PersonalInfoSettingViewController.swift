//
//  PersonalInfoSettingViewController.swift
//  CGVProject
//
//  Created by Wi on 13/12/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import UIKit

class PersonalInfoSettingViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var logoutButton: UIButton!
    var user: User?
    override func viewDidLoad() {
        super.viewDidLoad()
        logoutButton.layer.cornerRadius = 20
        navigationItem.backBarButtonItem = UIBarButtonItem(image: nil, style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .black
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutButtonDidTap(_ sender: Any) {
        UserManager.singleton.signOut(completion: {
            NotificationCenter.default.post(name: NSNotification.Name("LogoutBtnDidtap"), object: self)
            self.navigationController?.popViewController(animated: true)
        })
    }
    
}

extension PersonalInfoSettingViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "infoSetting", for: indexPath)
            cell.textLabel?.text = "회원정보수정"
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "remove", for: indexPath)
            cell.textLabel?.text = "회원탈퇴"
            cell.selectionStyle = .none
            return cell
            
        default: break
        }
        return UITableViewCell()
    }
}
extension PersonalInfoSettingViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print("회원정보수정")
            let  personalInfoSettingStoryboard = UIStoryboard(name: "PersonalInfoSetting",bundle: nil)
            guard let pCVC = personalInfoSettingStoryboard.instantiateViewController(withIdentifier: "PasswordConfirmViewController") as? PasswordConfirmViewController  else {
                return print("PasswordConfirmViewController faild")
            }
            pCVC.user = self.user
            UIApplication.shared.delegate?.window!!.rootViewController?.present(pCVC, animated: true)
        case 1:
            print("회원탈퇴")
            let  personalInfoSettingStoryboard = UIStoryboard(name: "PersonalInfoSetting", bundle: nil)
            guard let cancelVC = personalInfoSettingStoryboard.instantiateViewController(withIdentifier: "CancelMembershipViewController") as? CancelMembershipViewController  else {
                return print("CancelMembershipViewController faild")
            }
            UIApplication.shared.delegate?.window!!.rootViewController?.show(cancelVC, sender: nil)
        default:break
        }
    }
}
