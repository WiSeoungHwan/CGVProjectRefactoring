//
//  CollectionViewCell.swift
//  CGVProject
//
//  Created by PigFactory on 26/11/2018.
//  Copyright © 2018 PigFactory. All rights reserved.
//

import UIKit
import Kingfisher

class MoviePosterCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var posterView: UIImageView!

    //데이터 처리 #2 - poster model에 저장된 이미지 주소를 불러와서 collectionViewCell 안의 이미지뷰에 넣어준다.
    var model: MoviePosterCollectionViewCellModel! {
        
        didSet {
            posterView.kf.setImage(with: URL(string: model.moviePosterImageUrl))
        }
    }
    
    
    

}
