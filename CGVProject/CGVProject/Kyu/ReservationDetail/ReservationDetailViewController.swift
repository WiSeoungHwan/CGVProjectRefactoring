//
//  ReservationDetailViewController.swift
//  CGVProject
//
//  Created by Maru on 19/12/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import UIKit

class ReservationDetailViewController: UIViewController {

    var bookPk: Int?
    var book: [TheaterReservation]?
    var screen: ScreeningSet?
    var seat: [SeatsReserved]?
    @IBOutlet weak var reservationDetailView: ReservationDetailCustomView!
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        TicketManager.singleton.loadUserReservations { book in
            self.book = book
            self.screen = book.first?.screeningSet
            self.seat = book.first?.seatsReserved
            self.bookPk = book.first?.pk
            self.setReservationInfo()

        }

        setReservationInfo()
        closeReservationView()
        bookCancelButtonDidTap()
    }
    
    
    func setReservationInfo() {
       
        guard let reservation = self.reservationDetailView else { return }
    reservation.bookMovieTitleLabel.text = self.screen?.title
        reservation.bookMovieTheaterLabel.text = self.screen?.theater
        reservation.bookMovieTimeLabel.text = self.screen?.time
        reservation.bookMovieScreenLabel.text = self.seat?.first?.seatName
        guard let number = self.book?.first?.num else { return }
        reservation.bookNumberOfSeats.text = String(number)
        if let urlString = self.screen?.thumbImgUrl,
            let url = URL(string: urlString) {
            reservation.bookMoviePosterImageView.kf.setImage(with: url)
        }
        
        
    }
    
    func closeReservationView() {
        NotificationCenter.default.addObserver(self, selector: #selector(showMainView), name: Notification.Name("CloseButton"), object: nil)
    }
    @objc func showMainView() {
    dismiss(animated: false)
        MainViewController.showMainViewController()
    }
    
    func bookCancelButtonDidTap() {
        NotificationCenter.default.addObserver(self, selector: #selector(deleteReservation), name: NSNotification.Name(rawValue: "BookCancel"), object: nil)
    }
    
    @objc func deleteReservation() {
        guard let pk = self.bookPk else { return }
        print("\n------------ [ printPk ] -------------\n")
        print(pk)
        TicketManager.singleton.userReservationDelete(reservationPk: pk) {_ in
            self.dismiss(animated: false)
            MainViewController.showMainViewController()
        }
    }
    
}
    

