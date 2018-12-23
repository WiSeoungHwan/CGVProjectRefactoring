//
//  StillcutTableViewCell.swift
//  CGVProject
//
//  Created by Maru on 05/12/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import UIKit

class StillcutTableViewCell: UITableViewCell {

    var stillcutPhoto: [String] = []

    // 스틸컷 - 영화 스틸컷 담을 배열 생성(MovieViewController에서 pk값에 해당하는 정보 입력)
    //
    var stillcutURL: [MovieDetail.Stillcut]? {
        didSet {
            self.stillcutCollectionViewCell.reloadData()
        }
    }
    @IBOutlet weak var stillcutCollectionViewCell: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       stillcutCollectionViewCell.dataSource = self
        stillcutCollectionViewCell.delegate = self
        stillcutCollectionViewCell.register(UINib(nibName: "StillcutCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "StillcutCollectionViewCell")
        
    }
    
}

extension StillcutTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stillcutURL?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StillcutCollectionViewCell", for: indexPath) as! StillcutCollectionViewCell
        
        if let urlString = stillcutURL?[indexPath.item].imageUrl,
            let url = URL(string: urlString) {
            cell.stillcutImageView.kf.setImage(with: url)
        }
        
        return cell
    }
    
}

extension StillcutTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return collectionView.bounds.size
    }
        
}
