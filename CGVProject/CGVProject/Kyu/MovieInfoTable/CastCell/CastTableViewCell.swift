//
//  CastTableViewCell.swift
//  LoginView
//
//  Created by Maru on 30/11/2018.
//  Copyright © 2018 Maru. All rights reserved.
//

import UIKit

class CastTableViewCell: UITableViewCell {
    var directors: [MovieOfficialList.director]? {
        didSet {
            self.castCollectionView.reloadData()
        }
    }
    var actors: [MovieOfficialList.actor]? {
        didSet {
            self.castCollectionView.reloadData()
        }
    }
    
    @IBOutlet weak var castCollectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        castCollectionView.dataSource = self
        castCollectionView.delegate = self
        castCollectionView.register(UINib(nibName: "CastCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CastCollectionViewCell")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension CastTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (directors?.count ?? 0) + (actors?.count ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCollectionViewCell", for: indexPath) as! CastCollectionViewCell
        
        cell.castImageView.layer.cornerRadius = cell.castImageView.frame.height / 2
        cell.castImageView.layer.borderWidth = 1
        cell.castImageView.layer.borderColor = UIColor.clear.cgColor
        cell.castImageView.clipsToBounds = true
        
        switch indexPath.row {
        case 0:
            let director = directors?[indexPath.item]
//            cell.directorLabel.text = "감독"
            let korDirectorName = director?.director
            cell.castKoreanName.text = korDirectorName
            let engDirectName = director?.engDirector
            cell.castEnglishName.text = engDirectName
            if let directorImg = director?.profileImg,
                let url = URL(string: directorImg) {
                cell.castImageView.kf.setImage(with: url)
            }
            return cell
        default:
            let actor = actors?[indexPath.item - 1]
                let korActorName = actor?.actor
                let engActorName = actor?.engActor
                if let actorImg = actor?.profileImgUrl,
                    let url = URL(string: actorImg) {
                    cell.castImageView.kf.setImage(with: url)
                }
                cell.castKoreanName.text = korActorName
                cell.castEnglishName.text = engActorName
            return cell
        }
    }
    
    // collectionViewCell 아이템 사이즈 지정 !
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 2
        let height = collectionView.bounds.height / 3
        return CGSize(width: width, height: height)
    }
    
}
