//
//  HomePageViewCell.swift
//  CGVProject
//
//  Created by Wi on 27/11/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import UIKit

class HomeViewCell: UICollectionViewCell {

    var homeTableView  = UITableView()
    var model: HomeViewData?
    private var refreshControll = UIRefreshControl()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    func configure(){
        homeTableView.refreshControl = refreshControll
        homeTableView.separatorColor = .clear
        refreshControll.addTarget(self, action: #selector(tableViewRefresh), for: .valueChanged)
        homeTableView.separatorColor = .clear
        MovieManager.singleton.loadHomeViewData(nowOpen: true) { (homeViewData) in
            self.model = homeViewData
            self.homeTableView.reloadData()
        }
        // MARK:Noti
        NotificationCenter.default.addObserver(self, selector: #selector(movieChartDidTap), name: NSNotification.Name("MovieChart"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notReleaseMovieDidTap), name: NSNotification.Name("NotReleaseMovie"), object: nil)
        // MARK: Delegate,dataSource
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        // MARK: AddSubView
        self.addSubview(homeTableView)
        
        // MARK: Cell register
        
        homeTableView.register(UINib(nibName: "TrailerTableViewCell", bundle: nil), forCellReuseIdentifier: "Trailer")
        homeTableView.register(UINib(nibName: "MovieChartTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieChart")
        homeTableView.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: "Event")
        
        // MARK: AutoLayout
        autolayout()
    }
    @objc private func movieChartDidTap(){
        MovieManager.singleton.loadHomeViewData(nowOpen: true) { (homeViewData) in
            self.model = homeViewData
            self.homeTableView.reloadData()
        }
    }
    @objc private func notReleaseMovieDidTap(){
        MovieManager.singleton.loadHomeViewData(nowOpen: nil) { (homeViewData) in
            self.model = homeViewData
            self.homeTableView.reloadData()
        }
    }
    @objc private func tableViewRefresh(){
        MovieManager.singleton.loadHomeViewData(nowOpen: true) { (homeViewData) in
            self.model = homeViewData
            self.homeTableView.reloadData()
            self.refreshControll.endRefreshing()
        }
    }
    func autolayout(){
        // MARK: AutoLayout 설정
        homeTableView.translatesAutoresizingMaskIntoConstraints = false
        homeTableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        homeTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        homeTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        homeTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        
    }
    
}
extension HomeViewCell: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Trailer", for: indexPath) as! TrailerTableViewCell
            cell.clipsToBounds = true
            guard let trailer = model?.trailer else {print("trailer binding err");return cell}
            cell.model = trailer
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieChart", for: indexPath) as! MovieChartTableViewCell
            cell.movies = self.model?.chart
            cell.selectionStyle = .none
            return cell
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: "Event", for: indexPath) as! EventTableViewCell
        default:
            return cell
        }
        cell.selectionStyle = .none
        return cell
    }
    
    
}

extension HomeViewCell: UITableViewDelegate {
}
