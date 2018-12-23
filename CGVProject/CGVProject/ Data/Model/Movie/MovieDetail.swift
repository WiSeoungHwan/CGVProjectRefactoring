//
//  Movie.swift
//  CGVProject
//
//  Created by Wi on 03/12/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import Foundation

struct MovieDetail: Decodable{
    let pk: Int?
    let title: String?
    let directors: [director]?
    let age: String?
    let casts: [Cast]?
    let durationMin: Int?
    let openingDate: String?
    let genre: String?
    let description: String?
    let trailer: String?
    let reservationScore: Double?
    let nowShow: Bool?
    let mainImgUrl: String?
    let stillcuts: [Stillcut]?
    
    struct director: Decodable{
        let director: String?
    }
    struct Cast: Decodable{
        let actor: String?
    }
    struct Stillcut: Decodable {
        let imageUrl: String?
    }
}
