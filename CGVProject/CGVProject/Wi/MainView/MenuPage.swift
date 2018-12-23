//
//  MenuView.swift
//  CGVProject
//
//  Created by Wi on 26/11/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import UIKit
protocol MenuPageDelegete {
    func didPageScroll(scrollOffsetX: CGFloat)
    func endDraggingIndexPath(indexPath: IndexPath)
}
class MenuPage: UIView {
    // MARK: 메뉴 페이지 콜렉션 뷰 생성
    var pageCollectionView: UICollectionView = {
        // MARK: layout생성
        let collectionViewLayout = UICollectionViewFlowLayout()
        // MARK: 스크롤 방향 지정
        collectionViewLayout.scrollDirection = .horizontal
        // MARK: frame 기본
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100 , height:100), collectionViewLayout: collectionViewLayout)
        // MARK: autoLayout 설정
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    var delegate: MenuPageDelegete?
    let pageNames = ["Home", "Event","Store","MY"]
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    func configure(){
        // MARK: addSubView
        self.addSubview(pageCollectionView)
        
        // MARK: delegate, dataSource
        pageCollectionView.delegate = self
        pageCollectionView.dataSource = self
        
        // MARK: register
        pageCollectionView.register(HomeViewCell.self, forCellWithReuseIdentifier: "Home")
        pageCollectionView.register(EventViewCell.self, forCellWithReuseIdentifier: "Event")
        pageCollectionView.register(StoreViewCell.self, forCellWithReuseIdentifier: "Store")
        pageCollectionView.register(MYViewCell.self, forCellWithReuseIdentifier: "MY")
        
        // MARK: 기타 설정
        pageCollectionView.backgroundColor = .white
        pageCollectionView.showsHorizontalScrollIndicator = false
        pageCollectionView.isPagingEnabled = true
        
        
        // MARK: autolayout
        autolayout()
    }
    func autolayout(){
        pageCollectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        pageCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        pageCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        pageCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}

extension MenuPage: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pageNames[indexPath.row], for: indexPath)
        return cell
    }
    
    
}
extension MenuPage: UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let xOffset = scrollView.contentOffset.x / 4
        delegate?.didPageScroll(scrollOffsetX: xOffset)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let itemAt = Int(targetContentOffset.pointee.x / self.frame.width)
        let indexPath = IndexPath(item: itemAt, section: 0)
        delegate?.endDraggingIndexPath(indexPath: indexPath)
    }
    
    
}
extension MenuPage: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: pageCollectionView.frame.width, height: pageCollectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
