//
//  User.swift
//  CGVProject
//
//  Created by Wi on 07/12/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import Foundation


struct User: Codable{
    let pk: Int
    let username: String
    let password: String
    let lastName: String?
    let firstName: String?
    let email: String?
    let phoneNumber: String?
    
}
