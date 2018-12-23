//
//  MovieCollectionViewCell.swift
//  CGVProject
//
//  Created by Wi on 28/11/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import UIKit
import Kingfisher


class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var moviePoster: UIImageView!
    
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieRank: UILabel!
    @IBOutlet weak var advanceRate: UILabel!
    @IBOutlet weak var bookNow: UIButton!
    
    var model: MovieCollectionViewCellModel! {
        didSet {
            moviePoster.kf.setImage(with: URL(string: model.moviePosterImageUrl))
            movieName.text = model.movieName
            advanceRate.text = model.advanceRate
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bookNow.layer.borderColor = UIColor.lightGray.cgColor
        bookNow.layer.borderWidth = 1
        bookNow.layer.cornerRadius = 15
        moviePoster.isUserInteractionEnabled = true
        moviePoster.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(moviePosterTap)))
        
    }
    
    @objc func moviePosterTap(_ sender: UIGestureRecognizer){
    MainViewController.showMovieDetailPage(moviePk: model.moviePk)
        print("Moviepk:", model.moviePk)
    }
    @IBAction func bookBtnDidTap(_ sender: UIButton) {
        MainViewController.showCurrentMobvieBookPage(moviePk: model.moviePk)
    }
    
    

    
}
