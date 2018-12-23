//
//  MovieTitleModel.swift
//  CGVProject
//
//  Created by PigFactory on 17/12/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import Foundation

//데이터 처리 #1 - Movie class에 저장된 url img 주소를 생성한 변수에 넣어준다.
class MovieTitleModel {
    var movieTitle: String?
    var duration: Int?
    
    init(_ movieDetail: MovieDetail) {
        movieTitle = movieDetail.title!
        duration = movieDetail.durationMin!
    }
}
