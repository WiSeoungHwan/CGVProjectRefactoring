//
//  AnimationViewController.swift
//  CGVProject
//
//  Created by Wi on 18/12/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import UIKit

class AnimationViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        UIView.animate(withDuration: 2, animations: {
            self.scrollView.contentOffset.x += 300
        }) { (isFinish) in
            self.navigationController?.isNavigationBarHidden = false
            self.navigationController?.popViewController(animated: false)
        }
        // Do any additional setup after loading the view.
    }


}
