//
//  MovieCollectionViewCellModel.swift
//  CGVProject
//
//  Created by Wi on 03/12/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import Foundation
class MovieCollectionViewCellModel {
    var moviePk: Int
    var moviePosterImageUrl: String
    var movieName: String
    var advanceRate: String

    init(_ movie: HomeViewData.Movie) {
        moviePk = movie.pk
        moviePosterImageUrl = movie.thumbImgUrl
        movieName = movie.title
        advanceRate = String(movie.reservationScore)
    }
}
