//
//  SeatViewController.swift
//  CGVProject
//
//  Created by PigFactory on 29/11/2018.
//  Copyright © 2018 PigFactory. All rights reserved.
//

import UIKit

class SeatViewController: UIViewController {
    
    @IBOutlet var peopleNumbers: [UIView]!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var lockButton: UIButton!
    @IBOutlet weak var normalCount: UILabel!

    //하단 라벨
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var theaterInfo: UILabel!
    @IBOutlet weak var price: UILabel!
    var priceCount = 0

    
    @IBOutlet weak var aa: UICollectionView!
    
    var normalCounting = 0
    var checkingChooseSeats: [IndexPath] = []
    var reservedSeats: [Int] = []
    //좌석 정보 받아오기
    var pk: Int?
    var moviePk: Int?
    var theaterSeat: [TheaterSeats]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonRoundCorners(item: topButton, cornerRadius: 20)
        viewRoundCorners(item: bottomView, cornerRadius: 20)
        
        //좌석 정보 받아오기
        guard let pk = pk else {return}
        TicketManager.singleton.selectSeats(screenTimePk: pk) { TheaterSeats in
            self.theaterSeat = TheaterSeats
            self.aa.reloadData()
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("좌석데이터 넘어왔다2 성공입니다:", self.pk)
        alert()
    }
    
    func buttonRoundCorners(item: UIButton, cornerRadius: Double) {
        item.layer.cornerRadius = CGFloat(cornerRadius)
        item.clipsToBounds = true
        item.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func viewRoundCorners(item: UIView, cornerRadius: Double) {
        item.layer.cornerRadius = CGFloat(cornerRadius)
        item.clipsToBounds = true
        item.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    func alert() {
        let msg = "\n본 영화는 만 12세 이상 관람 가능한 영화입니다. 만 12세 미만 고객은 부모님 또는 만 19세 이상 보호자 동반 시 관람이 가능합니다. 연령 확인 불가 시 입장이 제한 될 수 있습니다.\n"
        let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
        let OKButton = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alert.addAction(OKButton)
        present(alert, animated: true)
    }
    
    @IBAction func handleSelection(_ sender: UIButton) {
//        peopleNumbers.forEach { (view) in
//            UIView.animate(withDuration: 5.0, animations: {
//                view.isHidden = !view.isHidden
//                //예전에는 했는데 지금은 할필요 없는가?
//                //맨 상단 button 위에서 내려오는것 처럼 안보이게 해줌
//                self.view.layoutIfNeeded()
//            })
//        }
        
        peopleNumbers.forEach { (view) in
            UIView.animateKeyframes(
                withDuration: 5.0,
                delay: 0.0,
                animations: {
                    view.isHidden = !view.isHidden
            })
        }
    }
    
    
    //일반인 사람수 선택
    @IBAction func normalCountButton(_ sender: UIStepper) {
        if checkingChooseSeats.count == 0 {
            normalCount.text = String(Int(sender.value))
            normalCounting = Int(sender.value)
        } else {
            normalCount.text = "0"
            normalCounting = 0
            sender.value = 0
            for i in 0..<checkingChooseSeats.count {
                aa.cellForItem(at: checkingChooseSeats[i])?.backgroundColor = .lightGray
            }
            checkingChooseSeats.removeAll()
        }
        
        //인원수가 0일때 lock button view가 뜸
        if normalCounting == 0 {
            lockButton.isHidden = false
        } else {
            lockButton.isHidden = true
        }
    }
    
    //인원수 선택하지 않았을때 떠있는 lock button view
    @IBAction func lockButton(_ sender: UIButton) {
        seatFirstAlert()
    }
    
    //view가 처음 뜰때 바로 뜨는 alert
    func seatFirstAlert() {
        let msg = "인원을 먼저 선택하세요"
        let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
        let OKButton = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alert.addAction(OKButton)
        present(alert, animated: true)
    }
    
    
    @IBAction func payment(_ sender: UIButton) {
        if reservedSeats.count >= 1 {
            print(self.pk!,self.reservedSeats)
            TicketManager.singleton.createReservations(screenTimePk: self.pk!, seatsPks: self.reservedSeats) { (theaterReservation) in
                
                self.dismiss(animated: true)
                
                print("showReservationDetail")
                let reservationDetailStoryboard = UIStoryboard(name: "ReservationDetail", bundle: nil)
                guard let reserVC = reservationDetailStoryboard.instantiateViewController(withIdentifier: "ReservationDetailViewController") as? ReservationDetailViewController  else {
                    return print("ReservationDetail faild")
                }
                UIApplication.shared.delegate?.window!!.rootViewController?.present(reserVC, animated: false)
                
                print(theaterReservation)
            }
        }
        
    }
    
    
}

extension SeatViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeatCollectionViewCell", for: indexPath) as! SeatCollectionViewCell
            guard let theaterSeat = self.theaterSeat?[indexPath.row] else { return cell }
        cell.model = SeatModel(theaterSeat)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if reservedSeats.contains(self.theaterSeat![indexPath.row].pk) {
            self.reservedSeats.remove(at: reservedSeats.index(of: self.theaterSeat![indexPath.row].pk)!)
//            self.checkingChooseSeats.remove(at: checkingChooseSeats.index(of: indexPath)!)
            collectionView.cellForItem(at: indexPath)?.backgroundColor = .lightGray
            priceCount -= 1
        } else {
            self.reservedSeats.append(self.theaterSeat![indexPath.row].pk)
//            self.checkingChooseSeats.append(indexPath)
            collectionView.cellForItem(at: indexPath)?.backgroundColor = .red
            priceCount += 1
        }
        price.text = "\(priceCount * 10000)원"
        print(reservedSeats)
    }
}
