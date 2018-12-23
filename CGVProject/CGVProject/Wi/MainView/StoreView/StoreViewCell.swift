//
//  StoreViewCell.swift
//  CGVProject
//
//  Created by Wi on 27/11/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import UIKit

class StoreViewCell: UICollectionViewCell {
    let storeScollView = UIScrollView()
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
        storeScollView.delegate = self
        storeScollView.addSubview(imageView)
        imageView.image = UIImage(named: "store")
        storeScollView.contentSize = CGSize(width: self.frame.width, height: 750)
        self.addSubview(storeScollView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: storeScollView.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: storeScollView.topAnchor).isActive = true
        storeScollView.translatesAutoresizingMaskIntoConstraints = false
        storeScollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        storeScollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        storeScollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        storeScollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}

extension StoreViewCell: UIScrollViewDelegate{
    
}
