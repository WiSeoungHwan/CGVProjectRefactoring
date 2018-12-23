//
//  TicketManager.swift
//  CGVProject
//
//  Created by Wi on 18/12/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import Foundation
import Alamofire

class TicketManager{
    static let singleton = TicketManager()
    let token = UserManager.singleton.token
    let header: HTTPHeaders = [
        "Content-Type": "application/json",
        "Authorization": UserManager.singleton.token ?? ""
    ]
    // MARK: 티켓리스트
    func ticketLoadMovieList(completion: @escaping (([TheaterMovieList]) -> Void)){    
        Alamofire.request(API.TheaterURL.theaterList, method: .get, headers: header)
        .validate()
            .responseData { (response) in
                switch response.result{
                case .success(let value):
                    do{
                        let theaterMovieListData = try JSONDecoder().decode([TheaterMovieList].self, from: value)
                        print("theaterMovieListData:", theaterMovieListData)
                        completion(theaterMovieListData)
                    }catch{
                        print("theaterMovieListData Decode Err:", error)
                    }
                    
                case .failure(let err):
                    print("theaterMovieListData Network err:",err.localizedDescription)
                }
        }
    }
    // MARK: 티켓 필터
    func ticketFilter(moviePk: Int,location: String?, time: String?,completion: @escaping ((TheaterInfo) -> Void) ){
        let prams: Parameters = [
            "location": location ?? "",
            "time" : time ?? ""
        ]

        Alamofire.request(API.TheaterURL.theaterFilter + "\(moviePk)/", method: .get, parameters: nil, headers: header)
        .validate()
            .responseData { (response) in
                switch response.result{
                case .success(let value):
                    do{
                        let theaterFilterData = try JSONDecoder().decode(TheaterInfo.self, from: value)
                        completion(theaterFilterData)
                    }catch{
                        print("theaterFilterData Decode Err:", error)
                    }
                    
                case .failure(let err):
                    print("TheaterFilter Network err:",err.localizedDescription)
                }
        }
    }
    // MARK: 좌석 선택
    
    func selectSeats(screenTimePk: Int,completion: @escaping (([TheaterSeats]) -> Void)){
        
        Alamofire.request(API.TheaterURL.seats + "\(screenTimePk)/", method: .get, headers: header)
        .validate()
            .responseData { (response) in
                switch response.result{
                case .success(let value):
                    do{
                        let seatsData = try JSONDecoder().decode([TheaterSeats].self, from: value)
                        completion(seatsData)
                    }catch{
                        print("seatsData Decode Err:", error)
                    }
                    
                case .failure(let err):
                    print("seatsData Network err:",err.localizedDescription)
                }
        }
        
    }
    func createReservations(screenTimePk: Int,seatsPks: [Int], completion: @escaping ((TheaterReservation) -> Void)){
        let prams: Parameters = [
            "screen": screenTimePk,
            "seats": seatsPks
        ]
        Alamofire.request(API.TheaterURL.reservations, method: .post, parameters: prams, encoding: JSONEncoding.default, headers: header)
        .validate()
            .responseData { (response) in
                switch response.result{
                case .success(let value):
                    do{
                        let reservationData = try JSONDecoder().decode(TheaterReservation.self, from: value)
                        completion(reservationData)
                        print("reservationData:", reservationData)
                    }catch{
                        print("reservationData Decode Err:", error)
                    }
                    
                case .failure(let err):
                    print("reservationData Network err:",err.localizedDescription)
                }
        }
    }
    
    func loadUserReservations(completion: @escaping (([TheaterReservation])-> Void)){
        
        print(UserManager.singleton.token)
        Alamofire.request(API.UserURL.userReservation + "\(33)/", method: .get,encoding: JSONEncoding.default,  headers: header)
        .validate()
            .responseData { (response) in
                switch response.result{
                case .success(let value):
                    do {
                         let userReservations = try JSONDecoder().decode([TheaterReservation].self, from: value)
                        completion(userReservations)
                    }catch{
                        print("userReservations decode :", error)
                    }
                   
                case .failure(let err):
                    print("loadUserReservations NetworkErr:",err.localizedDescription)
                }
        }
        
    }
    func userReservationDelete(reservationPk: Int,completion: @escaping ((TheaterReservation)-> Void)){
        
        Alamofire.request(API.UserURL.userReservation + "\(reservationPk)/", method: .patch, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseData { (response) in
                switch response.result{
                case .success(let value):
                    do {
                        let userReservations = try JSONDecoder().decode(TheaterReservation.self, from: value)
                        completion(userReservations)
                    }catch{
                        print("userReservations decode :", error)
                    }
                    
                case .failure(let err):
                    print("loadUserReservations NetworkErr:",err.localizedDescription)
                }
        }
    }
    
}
