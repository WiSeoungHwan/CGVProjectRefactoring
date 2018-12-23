//
//  InfoFixViewController.swift
//  CGVProject
//
//  Created by Wi on 13/12/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import UIKit
import Alamofire

class InfoFixViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var userInfoFixButton: UIButton!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var pwConfirmTextField: UITextField!
    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    var user: User?
    override func viewDidLoad() {
        super.viewDidLoad()
        userInfoFixButton.layer.cornerRadius = 20
        pwTextField.delegate = self
        pwConfirmTextField.delegate = self
        firstNameText.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        phoneNumberTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    @IBAction func userInfoFixButtonDidTap(_ sender: Any) {
        guard let userInfo = user else { print("In InfoFixViewController user is nil");return
        }
        guard pwTextField.text == pwConfirmTextField.text else { //Alart
            self.alert(msg: "비밀번호가 일치하지않습니다.")
            return
        }
        let password = pwTextField.text!
        let prams: Parameters = [
            "username": userInfo.username,
            "password": password,
            "firstName": self.firstNameText.text!,
            "lastName": self.lastNameTextField.text!,
            "email": self.emailTextField.text!,
            "phoneNumber": self.phoneNumberTextField.text!
        ]
        //회원 정보 수정 패치 요청
        print(UserManager.singleton.token)
        UserManager.singleton.patchUserProfile(pram: prams) { (user) in
            //Alart
            self.reLoginAlert(msg: "회원정보가 변경되었습니다. \n 다시 로그인 해주세요"){
            }
        }
        
    }
    func alert(msg: String) {
        let alert = UIAlertController(title: "회원정보수정", message: msg, preferredStyle: .alert)
        let OkAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(OkAction)
        present(alert, animated: true)
    }
    func reLoginAlert(msg: String,completion: @escaping (() -> Void)) {
        let alert = UIAlertController(title: "회원정보수정", message: msg, preferredStyle: .alert)
        let OkAction = UIAlertAction(title: "확인", style: .default){ (self) in
            MainViewController.showLoginPage()
            completion()
        }
        alert.addAction(OkAction)
        present(alert, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true) // 이전 뷰로 넘어갈 때 키보드 내리기
    }
    
    // 텍스트 필드 아닌 곳 터치하면 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    // 키보드 Done 눌렀을 때 내리기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pwTextField.resignFirstResponder()
        pwConfirmTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
        firstNameText.resignFirstResponder()
        emailTextField.resignFirstResponder()
        phoneNumberTextField.resignFirstResponder()
        return true
    }
}
