//
//  HomeViewNaviController.swift
//  CGVProject
//
//  Created by Wi on 26/11/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import UIKit

class HomeViewNaviController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barTintColor = .white
        //네비게이션 바 줄 없애기
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        

    }

}
