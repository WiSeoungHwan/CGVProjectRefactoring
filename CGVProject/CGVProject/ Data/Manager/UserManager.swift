//
//  UserManager.swift
//  CGVProject
//
//  Created by Wi on 07/12/2018.
//  Copyright © 2018 Wi. All rights reserved.
//
import UIKit
import Foundation
import Alamofire

class UserManager {
    static let singleton = UserManager()
    private var _token: String?

    
    var hasToken: Bool {
        guard _token == nil else { return true }
        if let token = UserDefaults.standard.string(forKey: "token") {
            _token = token
            return true
        }
        return false
    }
    
    var token: String? {
        get { return hasToken ? "token \(_token!)" : nil }
        set {
            _token = newValue
            UserDefaults.standard.set(newValue, forKey: "token")
        }
    }
    


    func signIn(param: Parameters,completion: @escaping (() -> Void)) {
        let header: HTTPHeaders = [ "Content-Type": "application/json"]

        Alamofire.request(API.AuthURL.signIn, method: .post, parameters: param, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    print("Success SignIn")
                    guard let token = value as? [String: String] else { return print("Token parsing error")}
                    UserManager.singleton.token = token["token"]
                    case .failure(let error):
                    print(error.localizedDescription)
                }
                completion()
                print(self.token as Any)
        }

    }
//    func alert() {
//        let msg: String?
//        let alert = UIAlertController(title: "로그인 에러", message: msg, preferredStyle: .alert)
//        let OkAction = UIAlertAction(title: "확인", style: .default, handler: nil)
//        alert.addAction(OkAction)
////        present(alert, animated: true)
//    }
    func checkPW(password: String, completion: @escaping ((Bool) -> Void)){
        let header: HTTPHeaders = [
        "Content-Type": "application/json",
        "Authorization": token ?? ""
        ]
        let pram: Parameters = [
            "password": password
        ]
        Alamofire.request(API.AuthURL.checkPW, method: .post, parameters: pram, encoding: JSONEncoding.default, headers: header)
        .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    print(value)
                    print(pram)
                    completion(true)
                case .failure(let err):
                    print("실패:",pram,header)
                    print(err.localizedDescription)
                    completion(false)
                }
                
                
      }
        
    }
    func userDelete(completion: @escaping ((Bool) -> Void)){
        let header: HTTPHeaders = [
            "Authorization": token ?? ""
            ]
        Alamofire.request(API.UserURL.userDelete, method: .delete, encoding: JSONEncoding.default, headers: header)
        .validate()
            .response { (response) in
                if response.response?.statusCode == 204 {
                    completion(true)
                    self.token = nil
                    print("회원탈퇴 성공")
                    return
                }
                completion(false)
                print("회원탈퇴 실패")
                print(response.response?.statusCode as Any)
                
        }
    }
    
    func signOut(completion: @escaping (() -> Void)){
        print("=== sign out ===")
        print("Token : ", token ?? "")

        let header: HTTPHeaders = [
            "Authorization": token ?? "",
        ]
        print("header :", header)
        Alamofire.request(API.AuthURL.signOut, method: .delete, headers: header)
            .validate()
            .response(completionHandler: { (response) in
                if response.response?.statusCode == 200 {
                    KOSession.shared()?.logoutAndClose(completionHandler: { (success, error) in
                        if let error = error {
                            return print("KakaoError: ",error.localizedDescription)
                        }
                        // Logout success
                        print("KaKaoLogout success")
                    })
                    UserManager.singleton.token = nil
                    completion()
                }
                else{ print("Logout Err")}
            })
    }
    
    // API 호출 상태값을 관리할 변수
    var isCalling = false
    
    func signUp(param: Parameters, completion: @escaping (()-> Void)) {
        
        // 인디케이터 뷰 애니메이션 시작
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        //        self indicatorView.startAnimating()
        
        // API 중복 송신 방지 코드
        if self.isCalling == true {
            print("진행 중입니다. 잠시만 기다려주세요.")
            return
        } else {
            self.isCalling = true
        }
        
        // 1. 전달할 값 준비
        // 1-1. 이미지 있으면 이미지 인코딩 처리
        
        // 1-3. header를 설정해서 json 형태로 인코딩 할 것을 서버에 전달
        let header: HTTPHeaders = [ "Content-Type" : "application/json"]
        
        // 2. API 호출, json 형태로 인코딩하여 body 전달

        Alamofire.request(API.AuthURL.signUp, method: .post, parameters: param, encoding: JSONEncoding.default, headers: header)
            .validate(statusCode: 200...300)
            .responseJSON { (response) in
                
                // 인디케이터 뷰 애니메이션 종료
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                //                self.indicatorView.stopAnimating()
                
                switch response.result {
                case .success(let user):
                    SignUpViewController.successToSignUp = true
                    print(SignUpViewController.successToSignUp)
                    print("가입완료 Login :", user)
                case .failure(let error):
                    self.isCalling = false
                    SignUpViewController.successToSignUp = false
                    print("가입 실패: ",error.localizedDescription)
                }
                completion()
        }
        
        
        
    }
    func patchUserProfile(pram: Parameters,completion: @escaping ((User) -> Void)){
        let header: HTTPHeaders = [
            "Authorization": token ?? "",
            "Content-Type" : "application/json"
        ]
        Alamofire.request(API.UserURL.userProfile, method: .patch, parameters: pram, encoding: JSONEncoding.default, headers: header)
        .validate()
            .responseData { (response) in
                switch response.result{
                case .success(let value):
                    let user = try! JSONDecoder().decode(User.self, from: value)
                    completion(user)
                    print(user)
                case .failure(let err):
                    print(err.localizedDescription)
                }
                print(pram)
                print(header)
        }
        
    }
    func getUserProfile(completion: @escaping ((User) -> Void)){
        let header: HTTPHeaders = [
            "Authorization": token ?? "",
            "Content-Type" : "application/json"
            ]
        Alamofire.request(API.UserURL.userProfile, method: .get, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseData { (response) in
                switch response.result{
                case .success(let value):
                    let user = try! JSONDecoder().decode(User.self, from: value)
                    completion(user)
                case .failure(let err):
                    print(err.localizedDescription)
                }
        }
        
    }
    
    // 카카오 로그인 시 카카오 ID로 토큰 받기
    func postKakaoUserId() {
        KOSessionTask.userMeTask { [weak self] (error, userMe) in
            if let error = error {
                return print(error.localizedDescription)
            }
            
            guard let me = userMe,
                let id = me.id else { return }
            //kakao login 시 받아 올 수 있는 id를 서버에 전달하여 토큰값 생성,
            // id만 전달하면 되지만 현재 서버 문제로 모든 파라미터를 채워서 보내야 토큰값이 생성 됨.
            let param: Parameters = ["user_id" : id, "last_name": "afsdf", "first_name": "sadfaf", "email": "dasifl", "phone_number": "czvzv"]
            print(id)
            
            let header: HTTPHeaders = ["Content-Type" : "application/json"]
            Alamofire.request(API.AuthURL.socialSignIn, method: .post, parameters: param, encoding: JSONEncoding.default, headers: header)
                .validate(statusCode: 200...300)
                .responseJSON(completionHandler: { (response) in
                    switch response.result {
                    case .success(let value):
                        print("token :", value)
                        // value에 토큰값이 들어오는데 딕셔너리로 들어오므로 딕셔너리로 타입을 바꿔준 다음에
                        // "token" 키값으로 토큰값을 받아온 뒤 UserManager의 token 변수에 담아준다.
                        guard let token = value as? [String: String] else { return print("token parsing error")}
                        UserManager.singleton.token = token["token"]
                        print("\n------------ [ success ] -------------\n")
                        print(UserManager.singleton.hasToken)
                        
                    case .failure(let error):
                        print("\n------------ [ fail ] -------------\n")
                        print(error.localizedDescription)
                        
                    }
                })
            
        }
    }
}
