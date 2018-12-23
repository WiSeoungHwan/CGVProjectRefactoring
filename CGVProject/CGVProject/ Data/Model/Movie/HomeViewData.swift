//
//  HomeViewData.swift
//  CGVProject
//
//  Created by Wi on 17/12/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import Foundation

struct HomeViewData: Codable{
    let trailer: Trailer
    let chart: [Movie]
    
    struct Trailer: Codable{
        let moviePk: Int
        let movieTrailer: String
        let postingImgUrl: String
        let movieTitle: String
        let comment: String
    }
    struct Movie: Codable{
        let pk: Int
        let title: String
        let age: String
        let reservationScore: Double
        let thumbImgUrl: String
        let openingDate: String
        let nowOpen: Bool
        let nowShow: Bool
    }
}
