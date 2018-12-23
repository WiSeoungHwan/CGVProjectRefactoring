//
//  AppDelegate.swift
//  CGVProject
//
//  Created by Wi on 26/11/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    // MARK: - App Life Cycle
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //유효하지 않은 토큰 삭제용
//        UserManager.singleton.token = nil
        initializeApp()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        KOSession.handleDidEnterBackground()
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        KOSession.handleDidBecomeActive()
    }
    
    func application(_ app: UIApplication, open url: URL, options:
        [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if KOSession.isKakaoAccountLoginCallback(url) {
            return KOSession.handleOpen(url)
        }
        //          else if facebook {
        //
        //        } else if instagram {
        //
        //        }
        return false
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // MARK: - Initialize App
    
    private func initializeApp() {
        setupSessionChangeNotification()
        setupRootViewController()
    }
    private func setupSessionChangeNotification() {
        NotificationCenter.default.addObserver(forName: .KOSessionDidChange, object: nil, queue: .main) { noti in
            
            guard let session = noti.object as? KOSession else { return }
            session.isOpen() ? print("SignIn") : print("SignOut")
            self.setupRootViewController()
        }
    }
    
    private func setupRootViewController() {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let navigationController = storyboard.instantiateViewController(withIdentifier: "HomeViewNaviController") as! HomeViewNaviController
        let animationVC = storyboard.instantiateViewController(withIdentifier: "AnimationViewController") as! AnimationViewController
        let storyboardID = KOSession.shared().isOpen() ? "MainViewController" : "MainViewController"
        let vc = storyboard.instantiateViewController(withIdentifier: storyboardID)
        navigationController.viewControllers = [vc]
        navigationController.show(animationVC, sender: nil)
        window?.rootViewController = navigationController
        
        
        
        
    }


}

