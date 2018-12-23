//
//  MovieChartTableViewCell.swift
//  CGVProject
//
//  Created by Wi on 28/11/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import UIKit
import Alamofire

class MovieChartTableViewCell: UITableViewCell {
    @IBOutlet weak var movieChart: UILabel!
    @IBOutlet weak var dot: UILabel!
    @IBOutlet weak var notReleaseMovie: UILabel!
    
    @IBOutlet weak var standardLabel: UILabel!
    @IBOutlet weak var currentTime: UILabel!
    
    @IBOutlet weak var movieChartCollectionView: UICollectionView!
    var movies: [HomeViewData.Movie]? {
        didSet{
            movieChartCollectionView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
//         Initialization code
        movieChartCollectionView.dataSource = self
        movieChartCollectionView.delegate = self
        movieChartCollectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil ), forCellWithReuseIdentifier: "MovieChart")
        
        //UIGesture
        movieChart.isUserInteractionEnabled = true
        notReleaseMovie.isUserInteractionEnabled = true
        movieChart.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(movieChartDidtap)))
        notReleaseMovie.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(notReleaseMovieDidtap)))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var isMovieChartBtnDIdtap = true
    @objc func movieChartDidtap(){
        NotificationCenter.default.post(name: NSNotification.Name("MovieChart"), object: nil)
        movieChart.textColor = .black
        notReleaseMovie.textColor = .lightGray
        isMovieChartBtnDIdtap = true
        print("movieChart")
    }
    @objc func notReleaseMovieDidtap(){
        NotificationCenter.default.post(name: NSNotification.Name("NotReleaseMovie"), object: nil)
        movieChart.textColor = .lightGray
        notReleaseMovie.textColor = .black
        isMovieChartBtnDIdtap = false
        print("NotReleaseMovie")
    }
}
extension MovieChartTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let movies = self.movies else {print("MovieList nil"); return 1}
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieChart", for: indexPath) as! MovieCollectionViewCell
        guard let movies = self.movies else {print("MovieList nil"); return cell}
        cell.model = MovieCollectionViewCellModel.init((movies[indexPath.row]))
        if isMovieChartBtnDIdtap{
            cell.movieRank.text = "\(indexPath.row + 1)"
        }else{
            cell.movieRank.text = ""
        }
        return cell
        
    }


}

extension MovieChartTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
}
