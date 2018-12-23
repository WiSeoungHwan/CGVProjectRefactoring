//
//  MenuCollectionViewCell.swift
//  CGVProject
//
//  Created by Wi on 26/11/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    // MARK: 타이틀 객체생성
    var titleLabel: UILabel = {
        let label = UILabel()
        // MARK: 글자 중앙정렬
        label.textAlignment = .center
        // MARK: 폰트 지정
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        // MARK: autolayout 설정
        label.translatesAutoresizingMaskIntoConstraints = false
        // MARK: color 지정
        label.textColor = .lightGray
        // MARK: test용 text
        label.text = "Test"
        
        return label
    }()
    override var isSelected: Bool {
        didSet{
            self.titleLabel.textColor = isSelected ? .black : .lightGray
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
        fatalError("init(coder:) has not been implemented")
    }
    private func configure(){
        // MARK: AddSubView
        self.addSubview(titleLabel)
        
        // MARK: autoLayout
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

    }
}
