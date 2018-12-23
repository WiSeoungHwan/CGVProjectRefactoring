
import UIKit

class BookingViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    //이 화면으로 넘어왔을때 선택된 포스터를 클릭후 다음 포스터를 눌렀을때 스크롤이 돌아가는것을 방지하기 위한 용도
    var firstScrollEnable = true
    
    //데이터처리 #3 - 영화 정보를 담을 공간을 생성
    var movies: [TheaterMovieList]?
    var movieDetails: MovieDetail?
    var theaterInfo: TheaterInfo?
    var moviePk: Int?
    var screentimePk: Int?
    var a = true
    var b: Int?
    
    @IBAction func unwindToBooking(_ unwindSegue: UIStoryboardSegue) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //print("----------------[1. view did load] ---------------")

        //영화 정보 받아오기
        TicketManager.singleton.ticketLoadMovieList { TheaterMovieList in
            self.movies = TheaterMovieList
            self.tableView.reloadData()
        }
        
        //처음 영화 상세 정보 받아오기
        guard let moviePk = moviePk else {return}
        MovieManager.singleton.loadMovieDetail(moviePk) { MovieDetails in
            self.movieDetails = MovieDetails
            self.tableView.reloadRows(at: [[0,0]], with: UITableView.RowAnimation.fade)
        }
        
        //상영관 상세 정보 받아오기
        TicketManager.singleton.ticketFilter(moviePk: moviePk, location: nil, time: nil) { (TheaterInfo) in
            self.theaterInfo = TheaterInfo
            self.tableView.reloadData()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(theaterTimeTableDidTap(_:)), name: NSNotification.Name("theaterTimeTableDidTap"), object: nil)
    }
    
    @objc private func theaterTimeTableDidTap(_ noti: Notification){
        guard let userInfo = noti.userInfo as? [String: Int?], let pk = userInfo["pk"] else {print("NotiPk err"); return}
        self.screentimePk = pk
        print("좌석데이터 넘어왔다. pk:",pk)
        let bookStoryboard = UIStoryboard(name: "Book", bundle: nil)
        guard let popVC = bookStoryboard.instantiateViewController(withIdentifier: "PopUpViewController") as? PopUpViewController  else {
            return print("Bookstoryborad faild")
        }
        
       popVC.scPk = pk
        UIApplication.shared.delegate?.window!!.rootViewController?.present(popVC, animated: true)
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        //print("----------------[2. view did appear] ---------------")

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        firstScrollEnable = true
    }
    
    /*
     static func showSeatPage(moviePk: Int){
     let bookStoryboard = UIStoryboard(name: "Book", bundle: nil)
     guard let seatVC = bookStoryboard.instantiateViewController(withIdentifier: "Seat") as? SeatViewController  else {
     return print("Bookstoryborad faild")
     }
     seatVC.moviePk = moviePk
     print("지금 누른 영화의 pk: ", moviePk)
     UIApplication.shared.delegate?.window!!.rootViewController?.show(seatVC, sender: nil)
     }
     */
    
}

extension BookingViewController: UITableViewDelegate, UITableViewDataSource {
    
    //첫번째 섹션(0) = title, poster, date
    //두번째 섹션(1) = theater
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else {
            guard let movies = self.theaterInfo else { return 1 }
            return movies.subLocation.count
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "BookingTableMovieTitleCell", for: indexPath) as! BookingTableMovieTitleCell
                
                //메인 화면에서 영화 클릭해서 들어왔을 때 바로 해당 타이틀 보여주기용
                //movie title 데이터 #5 - moive title, duration 넣어주기
                //collection cell을 선택할때도 다시 여기로 들어와진다
                guard let movieDetail = self.movieDetails else {print("movieDetail nil"); return cell}
                cell.model = MovieTitleModel.init(movieDetail)
                return cell

            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "BookingTableViewCell", for: indexPath) as! BookingTableViewCell
                cell.moviePk = moviePk
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "BookingDateTableViewCell", for: indexPath) as! BookingDateTableViewCell
                return cell
            default :
                let table = UITableViewCell()
                return table
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookingTheaterTableViewCell", for: indexPath) as! BookingTheaterTableViewCell
            guard let time = self.theaterInfo else { return cell }
            cell.model = BookingTheaterModel.init(time.subLocation[indexPath.row])
            b = indexPath.row
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                return 45
            case 1:
                return 190
            case 2:
                return 85
            default:
                return 10
            }
        } else {
            return 110
        }
    }
    
    //    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    //        //print("----------------[3. will display] ---------------")
    //
    //        if indexPath.section == 0 {
    //            switch indexPath.row {
    //            case 1:
    //                //print("kkkkk")
    //                (cell as? BookingTableViewCell)?.posterCollectionView.reloadData()
    //            default:
    //                break
    //            }
    //        }
    //    }
}

extension BookingViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
//    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
//        return true
//    }
    
    //tag = 0 > 포스터 콜렉션 셀
    //tag = 1 > 날짜 콜렉션 셀
    //tag = 2 > 극장 콜렉션 셀
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            guard let movies = self.movies else { return 1 }
            return movies.count
        case 1: //요일
            return 7
        case 2: //상영시간
            guard let movies = self.theaterInfo?.subLocation[b ?? 0].screenTime else { return 1 }
            return movies.count
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        
        //포스터 콜랙션
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookingPosterCollectionViewCell", for: indexPath) as! BookingPosterCollectionViewCell

            //데이터 처리 #5 - guard문을 통해 서버통신을 확인하고, movies에 저장된 영화포스터정보를 차례대로 cell.model에 넣어준다.
            guard let movies = movies else { print("movieList nil"); return cell }
            cell.model = MoviePosterCollectionViewCellModel.init(movies[indexPath.row])
            

            //print(movies.index(of: moviePk))
            if firstScrollEnable == true {
                for i in 0...20 {
                    if movies[i].pk == moviePk {
                        collectionView.selectItem(at: [0, i], animated: true, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)
                    }
                }
            }

            return cell
        
        //예약 가능 날짜
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookingDateCollectionViewCell", for: indexPath) as! BookingDateCollectionViewCell
            guard let movieDate = theaterInfo else {print("movieDate nil"); return cell }
            cell.model = BookingDateModel.init(movieDate.date[indexPath.row])
            if cell.show == false {
                cell.movieDate.textColor = .red
            } else {
                cell.movieDate.textColor = .white
            }
            return cell
            
        //상영시간 및 예약 가능 자석 표시
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookingTheaterCollectionViewCell", for: indexPath) as! BookingTheaterCollectionViewCell
            guard let time = theaterInfo else { return cell }
            cell.model = BookingTheaterModel.init(time.subLocation[b ?? 0].screenTime[indexPath.row])
//            cell.model = BookingTheaterModel.init((time.subLocation.first?.screenTime[indexPath.row])!)
            return cell
        default:
            let a = UICollectionViewCell()
            return a
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //print("----------------[4. collection View will display ] ---------------")
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        firstScrollEnable = false
        
        switch collectionView.tag {
        case 0:
            
            //누를때마다 영화 상세 정보 받아오기
            //1. 정보를 불러온다 > 2. { } 외부먼저 진행 > 3. { } 내부 진행
            MovieManager.singleton.loadMovieDetail(movies![indexPath.row].pk) { detail in
                self.movieDetails = detail
                //타이틀 리로드
                self.tableView.reloadRows(at: [[0, 0]], with: UITableView.RowAnimation.none)
            }
            
            //상영관 상세 정보 받아오기
            TicketManager.singleton.ticketFilter(moviePk: movies![indexPath.row].pk, location: nil, time: nil) { (TheaterInfo) in
                self.theaterInfo = TheaterInfo
                print("ssssssss: \(indexPath.row) : ", self.theaterInfo!.date, terminator: "\n")
                
                //상영관 리로드
                self.tableView.reloadSections([1, 1], with: UITableView.RowAnimation.none)
                //날짜 리로드
                self.tableView.reloadRows(at: [[0, 2]], with: UITableView.RowAnimation.none)
            }

            collectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        
        case 1:
            print("date")
        
        //time table collection cell
        case 2:
            print("time")

        default:
            print(0)
        }
    }

}
