//
//  CancelMembershipViewController.swift
//  CGVProject
//
//  Created by Wi on 13/12/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import UIKit

class CancelMembershipViewController: UIViewController {
    @IBOutlet weak var cancelMembershipBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelMembershipBtn.layer.cornerRadius = 20
        self.title = "회원 탈퇴"
    }
    func alert(msg: String) {
        let alert = UIAlertController(title: "회원탈퇴", message: msg, preferredStyle: .alert)
        let OkAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(OkAction)
        present(alert, animated: true)
    }
    @IBAction func cancelMembershipBtnDidTap(_ sender: Any) {
        //임시로 넘기기 
//        self.alert("탈퇴 되었습니다.")
//        MainViewController.showMainViewController()
        UserManager.singleton.userDelete { isSuccess in
            if isSuccess{
                self.alert("탈퇴 되었습니다.")
                MainViewController.showMainViewController()
            }
            else{
                self.alert("실패하였습니다. 잠시후 다시 시도해주세요")
            }
        }
    }
}
