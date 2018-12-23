//
//  TheaterInfo.swift
//  CGVProject
//
//  Created by Wi on 18/12/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import Foundation

struct TheaterInfo: Codable {
    let detail: Detail
    let movie: [Movie]
    let location: [Location]
    let subLocation: [SubLocation]
    let date: [DateElement]
}

struct DateElement: Codable {
    let date, weekday: String?
    let show: Bool?
}

struct Detail: Codable {
    let pk: Int
    let title, age: String
    let durationMin: Int
}

struct Location: Codable {
    let pk: Int
    let location: String
    let num: Int
}

struct Movie: Codable {
    let pk: Int
    let title: String
    let thumbImgUrl: String
}

struct SubLocation: Codable {
    let subLocation: String
    let screenTime: [ScreenTime]
    
}

struct ScreenTime: Codable {
    let pk: Int
    let auditoriumName, times: String
    let currentSeatsNo: Int
}
