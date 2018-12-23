//
//  Movie.swift
//  CGVProject
//
//  Created by Wi on 03/12/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import Foundation


struct Movie: Decodable{
    let trailer: [trailerInfo]
    let chart: [chartInfo]
    
    struct trailerInfo: Decodable {
        let moviePk: Int
        let movieTitle: String
        let movieTrailer: String
        let comment: String
        let postingImageUrl: String
    }
    
    struct chartInfo: Decodable {
        let pk: Int
        let title: String
        let age: String
        let reservationScore: Int
        let thumbImgUrl: String
        let openingDate: String
        let nowOpen: Bool
        let nowShow: Bool
    }
    
}
