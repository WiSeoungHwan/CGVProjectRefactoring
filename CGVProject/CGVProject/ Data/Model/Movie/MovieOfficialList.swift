//
//  MovieOfficialList.swift
//  CGVProject
//
//  Created by Maru on 18/12/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import Foundation

struct MovieOfficialList: Decodable {
    let directors: [director]?
    let casts: [actor]?
    
    struct director: Decodable {
        let director: String?
        let engDirector: String?
        let profileImg: String?
    }
    struct actor: Decodable {
        let actor: String?
        let engActor: String?
        let profileImgUrl: String?
    }
}
