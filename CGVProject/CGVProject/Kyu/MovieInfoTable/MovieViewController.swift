//
//  MovieInfoViewController.swift
//  LoginView
//
//  Created by Maru on 29/11/2018.
//  Copyright © 2018 Maru. All rights reserved.
//

import UIKit
import Kingfisher
import UserNotifications

class MovieViewController: UIViewController {
    
    @IBOutlet weak var movieInfoTableView: UITableView!
    var cellIdentifier: [String] = []
    var moviePk: Int?
    var model: MovieDetail?
    var cast: MovieOfficialList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MovieManager.singleton.loadMovieDetail(moviePk!) { movie in
            self.model = movie
            self.movieInfoTableView.reloadData()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(image: nil, style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem?.tintColor = .black
        }
        MovieManager.singleton.loadMovieOfficialList(moviePk!) { cast in
            self.cast = cast
            self.movieInfoTableView.reloadData()
        }
        
        // 셀 안의 Item 사이즈에 맞춰서 셀 높이 조절
        movieInfoTableView.rowHeight = UITableView.automaticDimension
        
        registerCell()
        UNUserNotificationCenter.current().delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(pushAlarm), name: Notification.Name("AlarmButton"), object: nil)
    }
    
    @objc func pushAlarm() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge], completionHandler: {didAllow,Error in })
        
        let content = UNMutableNotificationContent()
        content.title = "영화 개봉일 알람"
        content.subtitle = "Title: \(model?.title ?? "")"
        content.body = "개봉일: \(model?.openingDate ?? "")"
        content.badge = 1
        content.sound = UNNotificationSound.default
        
        // 영화 상영일 알림
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let movieDate = model?.openingDate
        let md = dateFormatter.date(from: movieDate ?? "")
        let movidDateComponents = Calendar.current.dateComponents([.year, .month, .day, ], from: md!)
      
// 현재 시간 +5초 후 알림
        let date = Date(timeIntervalSinceNow: 5)
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        //Adding Request
        // MARK: - identifier가 다 달라야만 Notification Grouping이 된다
        let request = UNNotificationRequest(identifier: "\(index)timerdone", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    private func registerCell() {
        movieInfoTableView.register(UINib(nibName: "MovieInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieInfoTableViewCell")
        cellIdentifier.append("MovieInfoTableViewCell")
        
        movieInfoTableView.register(UINib(nibName: "InfoTableViewCell", bundle: nil), forCellReuseIdentifier: "InfoTableViewCell")
        cellIdentifier.append("InfoTableViewCell")
        
        movieInfoTableView.register(UINib(nibName: "CastTableViewCell", bundle: nil), forCellReuseIdentifier: "CastTableViewCell")
        cellIdentifier.append("CastTableViewCell")
        
        movieInfoTableView.register(UINib(nibName: "DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "DescriptionTableViewCell")
        cellIdentifier.append("DescriptionTableViewCell")
        
        movieInfoTableView.register(UINib(nibName: "StillcutTableViewCell", bundle: nil), forCellReuseIdentifier: "StillcutTableViewCell")
        cellIdentifier.append("StillcutTableViewCell")

    }
    
    func presentShare() {
        print("shareImageTap")
        let text = "Movie Title"
        let textToShare = [text]
        // 엑티비티 뷰 컨트롤러 셋업
        let activityVC = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        // 제외하고 싶은 어플
        activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop]
        // 현재 뷰에서 present
        present(activityVC, animated: true, completion: nil)
    }
}



extension MovieViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellIdentifier.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieInfoTableViewCell", for: indexPath) as! MovieInfoTableViewCell
            cell.movieTitleLabel.text = model?.title
            cell.movieRatedImage.image = UIImage(named: model?.age ?? "12세 이상")
            cell.moviePosterImageView.kf.setImage(with: URL(string: model?.mainImgUrl ?? ""))
            cell.stillcutURL = model?.stillcuts
            cell.moviePk = moviePk
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell", for: indexPath) as! InfoTableViewCell
            cell.directorLabel.text = model?.directors?[indexPath.item - 1].director
            
            // ==================== CastLabel =====================
            var castStringArray: [String] = []
            let num = model?.casts?.count ?? 0
            for i in 0..<num {
                let castString = model?.casts?[i].actor ?? ""
                castStringArray.append(castString + ", ")
                let castArray = castStringArray.joined()
                cell.actorLabel.text = castArray
            }
            //              고차함수를 사용해 리팩토링 해볼것
            //            if let result = model?.cast?.compactMap({ $0.actor }).joined() {
            //                print(result)
            //            }
            // ===========================================
            
            cell.genreLabel.text = model?.genre ?? "드라마"
            cell.openDateLabel.text = model?.openingDate ?? "2019.01.23"
            cell.runningTimeLabel.text = model?.durationMin.map({ (String($0) + "분")
            }) ?? "120분"
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CastTableViewCell", for: indexPath) as! CastTableViewCell
            cell.directors = cast?.directors
            cell.actors = cast?.casts
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell", for: indexPath) as! DescriptionTableViewCell
            // 문자열 중에 '<br>'을 줄바꿈 '\n' 으로 바꿔주기
            let replaceString = model?.description?.replacingOccurrences(of: "<br>", with: "\n", options: NSString.CompareOptions.literal, range: nil)
            cell.descriptionLabel.text = replaceString
            // 문자열 중간중간에 있는 '<br>' 제거해주기
            // model?.description?.components(separatedBy: ["<", ">", "b", "r"]).joined()
            cell.descriptionLabel.sizeToFit()
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "StillcutTableViewCell", for: indexPath) as! StillcutTableViewCell
            cell.stillcutURL = model?.stillcuts
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell", for: indexPath) as! InfoTableViewCell
            return cell
            
        }
    }
    
    
}

extension MovieViewController : UNUserNotificationCenterDelegate{
    //To display notifications when app is running  inforeground

    //앱이 foreground에 있을 때. 즉 앱안에 있어도 push알림을 받게 해준다.
    //viewDidLoad()에 UNUserNotificationCenter.current().delegate = self를 추가해줄 것.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        let settingsViewController = UIViewController()
        settingsViewController.view.backgroundColor = .gray
        self.present(settingsViewController, animated: true, completion: nil)

    }

}

