//
//  InsideCollectionViewCell.swift
//  CGVProject
//
//  Created by PigFactory on 26/11/2018.
//  Copyright © 2018 PigFactory. All rights reserved.
//

import UIKit
import Kingfisher

class BookingPosterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bookingPosterView: UIImageView!
    var a: [Int] = []
    
    //데이터 처리 #2 - poster model에 저장된 이미지 주소를 불러와서 collectionViewCell 안의 이미지뷰에 넣어준다.
    var model: MoviePosterCollectionViewCellModel! {
        didSet {
            bookingPosterView.kf.setImage(with: URL(string: model.moviePosterImageUrl))
        }
    }
    
    override func awakeFromNib() {
        bookingPosterView.alpha = 0.5
    }

    override var isSelected: Bool {
        didSet {
            if isSelected {
                transform = CGAffineTransform(scaleX: 1.1 , y: 1.1)
                bookingPosterView.alpha = 1.0
                bookingPosterView.layer.borderWidth = 3.0
                bookingPosterView.layer.borderColor = UIColor.white.cgColor
            } else {

                transform = CGAffineTransform.identity
                bookingPosterView.layer.borderWidth = 0.0
                bookingPosterView.alpha = 0.5
            }
        }
    }
}
