//
//  SignUpViewController.swift
//  CGVProject
//
//  Created by Maru on 05/12/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import UIKit
import Alamofire

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var checkPasswordTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
   
    var successCheckOverlapID = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        checkPasswordTextField.delegate = self
        lastNameTextField.delegate = self
        firstNameTextField.delegate = self
        emailTextField.delegate = self
        phoneNumberTextField.delegate = self
        // 화면 나올 때 커서 시작 위치
        usernameTextField.becomeFirstResponder()
       
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification ,object: nil)
//        usernameTextField.becomeFirstResponder()
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
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
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        checkPasswordTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
        firstNameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        phoneNumberTextField.resignFirstResponder()
        return true
    }

//    @objc func keyboardWillShow(_ sender: Notification) {
//        self.view.frame.origin.y = -100
//    }
//    @objc func keyboardWillHide(_ sender: Notification) {
//        self.view.frame.origin.y = 0
//    }
    
    @IBAction func checkOverlapIDButton(_ sender: Any) {
        guard let checkID = usernameTextField.text else { return }
        let header: HTTPHeaders = ["Content-Type": "application/json"]
        let param: Parameters = ["username": checkID]
        Alamofire.request(API.AuthURL.checkID, method: .post, parameters: param, encoding: JSONEncoding.default, headers: header)
        .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    guard let message = value as? [String: String] else { return }
                    self.alert(message["message"]!)
                    self.successCheckOverlapID = true
                    self.passwordTextField.becomeFirstResponder()
                    
                case .failure:
                    self.alert("아이디를 입력 해주세요")
                }
        }
        
    }
    
    static var successToSignUp = false
    @IBAction func signUpButton(_ sender: Any) {
        if isValid() {
        // 1-2. 전달값을 Parameters 타입의 객체로 정의
        let param: Parameters = [
            "username": self.usernameTextField.text!,
            "password": self.passwordTextField.text!,
            "last_name": self.lastNameTextField.text!,
            "first_name": self.firstNameTextField.text!,
            "email": self.emailTextField.text!,
            "phone_number": self.phoneNumberTextField.text!
        ]

            UserManager.singleton.signUp(param: param) {
                print(SignUpViewController.successToSignUp)
                if SignUpViewController.successToSignUp == true {
                    self.alert("회원 가입 완료") {
                    self.dismiss(animated: true, completion: nil) }
                } else {
                    self.alert("회원 가입 실패, 내용을 확인해 주세요")
                    self.usernameTextField.becomeFirstResponder()
                }

            }
        }
    }
    
    func isValid() -> Bool {
        
        if usernameTextField.text?.count == 0 {
            usernameTextField.placeholder = "아이디를 입력해주세요"
            self.alert("아이디를 입력해주세요")
            usernameTextField.becomeFirstResponder()
            return false
        }
        
        if successCheckOverlapID == false {
            self.alert("아이디 중복체크를 해주세요")
            return false
        }
        
        if passwordTextField.text?.count == 0 {
            passwordTextField.placeholder = "8자리 이상, 대문자, 소문자, 숫자 포함"
            self.alert("비밀번호를 입력해 주세요")
            passwordTextField.becomeFirstResponder()
            return false
        }
        
        if passwordValidate(password: passwordTextField.text ?? "") == false {
            passwordTextField.placeholder = "8자리 이상, 대문자, 소문자, 숫자 포함"
            self.alert("비밀번호 양식이 맞지 않습니다")
            passwordTextField.becomeFirstResponder()
            return false
        }
        
        if checkPasswordTextField.text?.count == 0 {
            checkPasswordTextField.placeholder = "비밀번호를 재입력 해주세요"
            self.alert("비밀번호를 재입력 해주세요")
            checkPasswordTextField.becomeFirstResponder()
            return false
        } else if checkPasswordTextField.text != passwordTextField.text {
            checkPasswordTextField.placeholder = "비밀번호가 일치하지 않습니다"
            self.alert("비밀번호가 일치하지 않습니다")
            checkPasswordTextField.becomeFirstResponder()
            return false
        }
        
        if lastNameTextField.text?.count == 0 {
            self.alert("성을 입력해 주세요")
            lastNameTextField.becomeFirstResponder()
            return false
        }
        
        if firstNameTextField.text?.count == 0 {
            self.alert("이름을 입력해 주세요")
            firstNameTextField.becomeFirstResponder()
            return false
        }
    
        if emailTextField.text?.count == 0 {
            emailTextField.placeholder = "enter the your eamil"
            self.alert("email을 입력해 주세요")
            emailTextField.becomeFirstResponder()
            return false
        }
        
        if emailValidate(email: emailTextField.text ?? "") == false {
            emailTextField.placeholder = "정확한 email 주소를 적어주세요"
            self.alert("정확한 email 주소를 적어주세요")
            emailTextField.becomeFirstResponder()
            return false
        }
        
        if phoneNumberTextField.text?.count == 0 {
            phoneNumberTextField.placeholder = "전화번호를 입력해 주세요"
            self.alert("전화번호를 입력해 주세요")
            phoneNumberTextField.becomeFirstResponder()
            return false
        }
        
        return true
    }
    
    
    func passwordValidate(password: String) -> Bool {
        let passwordRegEx = "^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[a-z])(?=.*?[`~!@#$%^&*-_=+/?]).{8,20}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return predicate.evaluate(with: password)
    }
    
    func emailValidate(email: String) -> Bool {
        let emailRegEx = "^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: email)
    }
}
