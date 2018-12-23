//
//  MenuBar.swift
//  CGVProject
//
//  Created by Wi on 26/11/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import UIKit
protocol MenuBarDelegate {
    func didSelectItem(scollTo index: Int)
}
class MenuBar: UIView {
    // MARK: Tabbar 역할을 하는 컬렉션 뷰 생성
    let menuColletionView: UICollectionView = {
        // MARK: collectionView에 들어갈 FlowLayout 생성
        let collectionViewLayout = UICollectionViewFlowLayout()
        // MARK: 스크롤 방향을 가로방향으로 지정
        collectionViewLayout.scrollDirection = .horizontal
        // MARK: frame은 오토레이아웃으로 지정할것이기 때문에 0 으로 지정, layout은 위에서 만든 레이아웃 넣어주기
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: collectionViewLayout)
        // MARK: 스크롤 막기
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        // MARK: 다중 선택 막기
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        // MARK: autoLayout 설정
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: 배경 색 지정
        collectionView.backgroundColor = .white
        
        return collectionView
    }()
    // MARK: 선택된 메뉴를 따라다니는 바 생성
    var indicatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    // MARK: 메뉴의 타이틀 배열
    let menuTitles = ["홈","이벤트","스토어","MY"]
    
    // MARK: delegete
    var delegete: MenuBarDelegate?
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
        self.addSubview(menuColletionView)
        self.addSubview(indicatorView)
        
        // MARK: 초기 셀을 하나 등록함
        menuColletionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: "menuCell")
        // MARK: collectionView의 delegate,dataSource연결
        menuColletionView.delegate = self
        menuColletionView.dataSource = self
        
        // MARK: autolayout
        autolayout()
    }
    //MARK: indicator Properties
    var indicatorViewLeadingConstraint:NSLayoutConstraint!
    var indicatorViewWidthConstraint: NSLayoutConstraint!
    // MARK: autoLayout
    func autolayout(){
        // MARK: menuCollectionView
        
        menuColletionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        menuColletionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        menuColletionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        menuColletionView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        // MARK: indicatorView
        // 나중에 동적으로 변할 부분이기 때문에 따로 변수로 뺴놓는다.
        indicatorViewLeadingConstraint = indicatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        indicatorViewLeadingConstraint.isActive = true
        indicatorViewWidthConstraint = indicatorView.widthAnchor.constraint(equalToConstant: self.frame.width / CGFloat(menuTitles.count))
        indicatorViewWidthConstraint.isActive = true
        // 높이 조절
        indicatorView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        indicatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
}

// MARK: CollectionViewDataSource

extension MenuBar: UICollectionViewDataSource{
    // MARK: 하나의 섹션안의 아이템 숫자
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuTitles.count
    }
    // MARK: collectionView에 뿌려질 cell 반환 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // MARK: collectionViewCell 이 재사용되는 함수, MenuCollectionView의 프로퍼티에 접근하기 위해 타입 변환
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as? MenuCollectionViewCell
            else {
                print("cell 타입변환 실패")
                let somethingcell = UICollectionViewCell()
                return somethingcell
            }
        cell.titleLabel.text = menuTitles[indexPath.row]
        return cell
    }
    
    
}
extension MenuBar: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegete?.didSelectItem(scollTo: indexPath.row)
        guard let cell = collectionView.cellForItem(at: indexPath) as? MenuCollectionViewCell else {return}
        cell.titleLabel.textColor = .black
        print("메뉴바 선택됨")
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? MenuCollectionViewCell else {return}
        cell.titleLabel.textColor = .lightGray
    }
    
}


//MARK:- UICollectionViewDelegateFlowLayout
extension MenuBar: UICollectionViewDelegateFlowLayout {
    // MARK: 각 셀의 사이즈 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width / CGFloat(self.menuTitles.count), height: 50)
    }
    // MARK: collectionView 안으로 엣지를 얼마나 넣을 것 인지
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    // MARK: 최소 셀사이의 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
