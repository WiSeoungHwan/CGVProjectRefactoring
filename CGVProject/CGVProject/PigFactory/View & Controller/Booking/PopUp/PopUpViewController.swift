//
//  PopUpViewController.swift
//  CGVProject
//
//  Created by PigFactory on 29/11/2018.
//  Copyright © 2018 PigFactory. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {

    @IBOutlet weak var baseWindow: UIView!
    
    var scPk: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        baseWindow.layer.cornerRadius = 10
    }
    

    @IBAction func setupButtonTap(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func selectSeat(_ sender: Any) {
        let bookStoryboard = UIStoryboard(name: "Book", bundle: nil)
        guard let seatVC = bookStoryboard.instantiateViewController(withIdentifier: "Seat") as? SeatViewController  else {
            return print("Bookstoryborad faild")
        }
        seatVC.pk = self.scPk
        dismiss(animated: true) {
            UIApplication.shared.delegate?.window!!.rootViewController?.present(seatVC, animated: false)
        }
    }
}
