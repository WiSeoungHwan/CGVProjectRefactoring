//
//  ReservationDetailCustomView.swift
//  CGVProject
//
//  Created by Maru on 19/12/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import UIKit
import UserNotifications

class ReservationDetailCustomView: UIView {

    private let xibName = "ReservationDetailCustomView"
    
    @IBAction func closeButton(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("CloseButton"), object: nil)
    }
    
    @IBOutlet weak var bookMoviePosterImageView: UIImageView!
    @IBOutlet weak var bookMovieTitleLabel: UILabel!
    @IBOutlet weak var bookMovieTheaterLabel: UILabel!
    @IBOutlet weak var bookMovieScreenLabel: UILabel!
    @IBOutlet weak var bookMovieTimeLabel: UILabel!
    @IBOutlet weak var bookNumberOfSeats: UILabel!
    
    
    @IBAction func bookCancelButton(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("BookCancel"), object: nil)
    }
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        let view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
        
    }

}
