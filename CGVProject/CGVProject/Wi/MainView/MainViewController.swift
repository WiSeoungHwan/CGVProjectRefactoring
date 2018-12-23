//
//  HomeViewController.swift
//  CGVProject
//
//  Created by Wi on 26/11/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import UIKit

class MainViewController: UIViewController{
    // MARK: MainView Instance
    let mainView = MainView()
    
    // MARK: SideMenu Instance
    let sideMenu = SideMenu()
    let sideMenuWidth: CGFloat = 300
//    let aniVC = AnimationViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("token:",UserManager.singleton.token)
        configure()
        let leftNaviButton = UIBarButtonItem(image: UIImage(named: "cgvLogo"), style: .plain, target: self, action: #selector(cgvBtnDidTap))
        self.navigationController?.navigationBar.contentMode = .left
        self.navigationItem.leftBarButtonItem = leftNaviButton
        let rightNaviButton = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(showSideMenu))
        self.navigationItem.rightBarButtonItem = rightNaviButton
        navigationItem.backBarButtonItem = UIBarButtonItem(image: nil, style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .black
//        self.navigationItem.backBarButtonItem = backNaviButton
//        present(aniVC, animated: false, completion: nil)
    }
    var isSidemenuOpen = false
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sideMenu.tableView.reloadData()
        
    }
    @objc private func cgvBtnDidTap(){
        mainView.didSelectItem(scollTo: 0)
    }
    @objc private func closeSideMenu(){
        print("tapView")
        if isSidemenuOpen {
            sideMenuTrailingConstraints?.constant = sideMenuWidth
            UIView.animate(withDuration: 0.4) {
                self.view.layoutIfNeeded()
            }
        }
    }
    @objc private func showSideMenu(){
        print("sideMenuBtnTap")
        sideMenu.tableView.reloadData()
        if sideMenuTrailingConstraints?.constant == 0{
            isSidemenuOpen = false
            sideMenuTrailingConstraints?.constant = sideMenuWidth
        }else{
            isSidemenuOpen = true
            sideMenuTrailingConstraints?.constant = 0
        }
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        }
        print("isSidemenu Open: ", isSidemenuOpen)
    }
    
    // MARK: static func
    static func showReservationPage(){
        
        print("showReservationDetail")
        let reservationDetailStoryboard = UIStoryboard(name: "ReservationDetail", bundle: nil)
        guard let reserVC = reservationDetailStoryboard.instantiateViewController(withIdentifier: "ReservationDetailViewController") as? ReservationDetailViewController  else {
            return print("ReservationDetail faild")
        }
        UIApplication.shared.delegate?.window!!.rootViewController?.present(reserVC, animated: false)
    }
    static func showMainViewController(){
        print("showMainViewController")
        let homeStoryboard = UIStoryboard(name: "Home", bundle: nil)
        guard let mainVC = homeStoryboard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController  else {
            return print("Homestoryborad faild")
        }
        UIApplication.shared.delegate?.window!!.rootViewController?.show(mainVC, sender: nil)
    }
    
    
    static func showBookPage(){
        print("showBookPageFunc")
        let bookStoryboard = UIStoryboard(name: "Book", bundle: nil)
        guard let startVC = bookStoryboard.instantiateViewController(withIdentifier: "StartViewController") as? StartViewController  else {
            return print("Bookstoryborad faild")
        }
        UIApplication.shared.delegate?.window!!.rootViewController?.show(startVC, sender: nil)
    }
    static func showCurrentMobvieBookPage(moviePk: Int){
        print("showCurrentMobvieBookPage")
        let bookStoryboard = UIStoryboard(name: "Book", bundle: nil)
        guard let bookingVC = bookStoryboard.instantiateViewController(withIdentifier: "booking") as? BookingViewController  else {
            return print("Bookstoryborad faild")
        }
        bookingVC.moviePk = moviePk
        print("지금 누른 영화의 pk: ", moviePk)
        UIApplication.shared.delegate?.window!!.rootViewController?.show(bookingVC, sender: nil)
    }
    static func showLoginPage(){
        print("showLoginPage")
        let loginStoryboard = UIStoryboard(name: "Login",bundle: nil)
        guard let loginVC = loginStoryboard.instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController  else {
            return print("Loginstoryborad faild")
        }
        UIApplication.shared.delegate?.window!!.rootViewController?.present(loginVC, animated: true)
    }
    static func showMovieDetailPage(moviePk: Int){
        print("showMovieDetailPage")
        
        let MovieDetailStoryboard = UIStoryboard(name: "MovieInfoStoryboard",bundle: nil)
        guard let MovieDetailVC = MovieDetailStoryboard.instantiateViewController(withIdentifier: "MovieViewController") as?  MovieViewController else {
            return print("MovieDetailStoryboard faild")
        }
        MovieDetailVC.moviePk = moviePk
        UIApplication.shared.delegate?.window!!.rootViewController?.show(MovieDetailVC, sender: nil)

    }
    static func showPersonalInfoSetting(user: User?){
        print("showLoginPage")
        let personalStoryboard = UIStoryboard(name: "PersonalInfoSetting",bundle: nil)
        guard let personalVC = personalStoryboard.instantiateViewController(withIdentifier: "PersonalInfoSettingViewController") as? PersonalInfoSettingViewController  else {
            return print("PersonalInfoSettingViewController faild")
        }
           personalVC.user = user
        UIApplication.shared.delegate?.window!!.rootViewController?.show(personalVC, sender: nil)
    }
    
    // MARK: configure
    
    private func configure(){
        
        // MARK: delegate
        
        
        // MARK: MainView
        mainView.menuBar.indicatorViewWidthConstraint.constant = view.frame.width / 4
        // MARK: autolayout setting
        sideMenu.translatesAutoresizingMaskIntoConstraints = false
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: addSubview
        view.addSubview(mainView)
        view.addSubview(sideMenu)
        
        // MARK: autolayout
        autolayout()
        
    }
    // MARK: Autolayout
    var sideMenuSlideWitdthConstraints: NSLayoutConstraint?
    var sideMenuTrailingConstraints: NSLayoutConstraint?
    private func autolayout(){

        // MARK: mainView
        mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: sideMenu.leadingAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mainView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        
        // MARK: sideMenu
        
        sideMenu.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        sideMenu.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        sideMenuSlideWitdthConstraints = sideMenu.widthAnchor.constraint(equalToConstant: sideMenuWidth)
        sideMenuSlideWitdthConstraints!.isActive = true
        
        sideMenuTrailingConstraints = sideMenu.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: sideMenuWidth)
        sideMenuTrailingConstraints!.isActive = true
    }

    // kyu 추가 , SignIn page에 CGV button 연결
    @IBAction func unwindToMainViewController(_ unwindSegue: UIStoryboardSegue) {

    }
}
