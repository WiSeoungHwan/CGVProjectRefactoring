//
//  TrailerTableViewCellModel.swift
//  CGVProject
//
//  Created by Wi on 09/12/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import Foundation

class TrailerTableViewCellModel {
    var moviePk: Int
    var youtubeUrl: String
    var titleImageUrl: String
    var title: String
    var subTitle: String
    
    init(trailer: HomeViewData.Trailer ) {
        youtubeUrl = trailer.movieTrailer
        titleImageUrl = trailer.postingImgUrl
        title = trailer.comment
        subTitle = trailer.movieTitle
        moviePk = trailer.moviePk
    }
    
}
