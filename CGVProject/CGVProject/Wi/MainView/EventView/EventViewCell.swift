//
//  EventViewCell.swift
//  CGVProject
//
//  Created by Wi on 27/11/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import UIKit

class EventViewCell: UICollectionViewCell {
    let eventScollView = UIScrollView()
    let imageView = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    func configure(){
        eventScollView.delegate = self
        eventScollView.addSubview(imageView)
        imageView.image = UIImage(named: "event")
        eventScollView.contentSize = CGSize(width: self.frame.width, height: 1600)
        self.addSubview(eventScollView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: eventScollView.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: eventScollView.topAnchor).isActive = true
        eventScollView.translatesAutoresizingMaskIntoConstraints = false
        eventScollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        eventScollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        eventScollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        eventScollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}

extension EventViewCell: UIScrollViewDelegate{

}
