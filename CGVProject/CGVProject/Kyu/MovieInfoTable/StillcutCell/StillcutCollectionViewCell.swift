//
//  StillcutCollectionViewCell.swift
//  CGVProject
//
//  Created by Maru on 05/12/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import UIKit

class StillcutCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var stillcutImageView: UIImageView!
    
     //데이터 처리 #2 - poster model에 저장된 이미지 주소를 불러와서 collectionViewCell 안의 이미지뷰에 넣어준다.
//    var model: StillCutCollectionViewCellModel! {
//        didSet {
//            
//            var stillCutUrl: String?
//            guard let count = model.stillCutImageUrl?.count else { return }
//            for i in 0..<count {
//                stillCutUrl = model.stillCutImageUrl?[i]
//                stillcutImageView.kf.setImage(with: URL(string: stillCutUrl ?? ""))
//            }
//            
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
