//
//  SignInViewController.swift
//  LoginView
//
//  Created by Maru on 22/11/2018.
//  Copyright © 2018 Maru. All rights reserved.
//

import UIKit
import Alamofire

class SignInViewController: UIViewController {

    
    @IBOutlet weak var idTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signInButton(_ sender: Any) {
        
        guard let id = idTextfield.text,
              let password = passwordTextfield.text else { return }
        if id.isEmpty { alert(msg: "아이디와 패스워드를 입력해 주세요") }
        let param: Parameters = [ "username": id, "password": password]
        
        UserManager.singleton.signIn(param: param) {
            if UserManager.singleton.hasToken {
            NotificationCenter.default.post(name: Notification.Name("LoginButtonDidTap"), object: self)
            MainViewController.showMainViewController()
            self.dismiss(animated: true, completion: nil)
            } else {
                self.alert(msg: "아이디와 비밀번호를 다시 확인해 주세요")
            }
        }
        
    }
    
    func alert(msg: String) {
        let alert = UIAlertController(title: "로그인", message: msg, preferredStyle: .alert)
        let OkAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(OkAction)
        present(alert, animated: true)
    }
    
    @IBAction func kakaoSignInButton(_ sender: Any) {
        guard let session = KOSession.shared() else { return }
       
        
//        // close old session
        session.isOpen() ? session.close() : ()

        session.open(completionHandler:  { (error) in
//            guard session.isOpen() else {
//                // Open Session field
//                return
//            }

            if !session.isOpen() {
                if let error = error as NSError? {
                    switch error.code {
                    case Int(KOErrorCancelled.rawValue):
                        print("Cancelled")
                    default:
                        print(error.localizedDescription)
                    }
                }
            } else {
                print("SignIn Success")
                UserManager.singleton.postKakaoUserId()
                
            }
        }, authTypes: [NSNumber(value: KOAuthType.talk.rawValue)])
            }
    
    
    
    @IBAction func unwindToSignInViewController(_ unwindSegue: UIStoryboardSegue) {
        
    }
    
}
