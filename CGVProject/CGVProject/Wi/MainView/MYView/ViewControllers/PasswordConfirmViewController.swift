//
//  PasswordConfirmViewController.swift
//  CGVProject
//
//  Created by Wi on 13/12/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import UIKit

class PasswordConfirmViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordNotConfirm: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var okButton: UIButton!
    
    var user: User?
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordNotConfirm.alpha = 0
        // Do any additional setup after loading the view.
    }
    
    @IBAction func xButtonDidTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func okButtonDidTap(_ sender: Any) {
        //임시로 넘기는 코드
//        let  personalInfoSettingStoryboard = UIStoryboard(name: "PersonalInfoSetting",bundle: nil)
//        guard let iFVC = personalInfoSettingStoryboard.instantiateViewController(withIdentifier: "InfoFixViewController") as? InfoFixViewController  else {
//            return print("InfoFixViewController faild")
//        }
//        iFVC.user = self.user
//        self.dismiss(animated: false) {
//            UIApplication.shared.delegate?.window!!.rootViewController?.show(iFVC, sender: true)
//        }
        UserManager.singleton.checkPW(password: passwordTextField.text ?? "") { (isSuccess) in
            if isSuccess {
                // 회원정보 수정화면
                let  personalInfoSettingStoryboard = UIStoryboard(name: "PersonalInfoSetting",bundle: nil)
                guard let iFVC = personalInfoSettingStoryboard.instantiateViewController(withIdentifier: "InfoFixViewController") as? InfoFixViewController  else {
                    return print("InfoFixViewController faild")
                }
                iFVC.user = self.user
                self.dismiss(animated: false) {
                    UIApplication.shared.delegate?.window!!.rootViewController?.show(iFVC, sender: true)
                }
                return
            }
            self.passwordTextField.borderStyle = .bezel
            self.passwordTextField.text = ""
            self.passwordNotConfirm.alpha = 1
            self.passwordTextField.layer.borderColor = UIColor.red.cgColor
        }
        
    }
    
    @IBAction func cancelButtonDidtap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
