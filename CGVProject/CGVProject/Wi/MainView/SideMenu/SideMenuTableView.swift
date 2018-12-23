//
//  SideMenuTableView.swift
//  CGVProject
//
//  Created by Wi on 01/12/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import UIKit

class SideMenuTableView: UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    func configure(){
        
    }
}
extension SideMenuTableView: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel!.text = "sdfsdfsdf"
        return cell
    }
    
    
}
extension SideMenuTableView: UITableViewDelegate{
    
}
