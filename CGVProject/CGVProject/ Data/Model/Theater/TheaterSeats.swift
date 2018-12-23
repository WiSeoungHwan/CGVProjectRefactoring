//
//  TheaterSeats.swift
//  CGVProject
//
//  Created by Wi on 18/12/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import Foundation


struct TheaterSeats : Codable {
    let pk, row, number: Int
    let seatName: String
    let reservationCheck: Bool
}
