//
//  MainView.swift
//  CGVProject
//
//  Created by Wi on 01/12/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import UIKit

class MainView: UIView, MenuBarDelegate, MenuPageDelegete {

    // MARK: MenuBar Instance
    let menuBar = MenuBar()
    
    // MARK: MenuPage Instance
    let menuPage = MenuPage()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    
    func configure(){
        menuBar.menuColletionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: [])
        
        // MARK: delegate
        menuBar.delegete = self
        menuPage.delegate = self
        
        // MARK: autolayout 설정
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        menuPage.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: addSubView
        
        self.addSubview(menuBar)
        self.addSubview(menuPage)
        
        // MARK: autoLayout
        autolayout()
    }
    // MARK: delegate Functions
    func didSelectItem(scollTo index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        menuBar.menuColletionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        menuPage.pageCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    func didPageScroll(scrollOffsetX: CGFloat) {
        menuBar.indicatorViewLeadingConstraint.constant = scrollOffsetX
    }
    func endDraggingIndexPath(indexPath: IndexPath) {
        menuBar.menuColletionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
    }
    func autolayout(){
        
        
        // MARK:menuBar
        menuBar.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        menuBar.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        menuBar.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        menuBar.bottomAnchor.constraint(equalTo: menuPage.topAnchor).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        // MARK:menuPage
        menuPage.topAnchor.constraint(equalTo: menuBar.bottomAnchor).isActive = true
        menuPage.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        menuPage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        menuPage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

}
