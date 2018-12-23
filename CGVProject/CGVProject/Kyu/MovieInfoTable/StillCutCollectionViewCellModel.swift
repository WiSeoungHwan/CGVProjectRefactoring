//
//  StillCutCollectionViewCellModel.swift
//  CGVProject
//
//  Created by Maru on 11/12/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import Foundation

//데이터 처리 #1 - Movie class에 저장된 url img 주소를 생성한 변수에 넣어준다.
class StillCutCollectionViewCellModel {
    var stillCutImageUrl: [String]?
    init(_ detail: MovieDetail) {

        var a: [String] = []
        guard let num = detail.stillcuts?.count else { return }
        for i in 0..<num {
        let b = detail.stillcuts?[i].imageUrl ?? ""
            a.append(b)
        }
        stillCutImageUrl = a
    }
}
