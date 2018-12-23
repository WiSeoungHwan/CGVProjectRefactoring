//
//  SideMenu.swift
//  CGVProject
//
//  Created by Wi on 30/11/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import UIKit

class SideMenu: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    private var buttonName: [String]{
        if UserManager.singleton.hasToken {
            return ["Login","영화별 예매","극장별 예매", "로그아웃"]
        }
        return ["Login","영화별 예매","극장별 예매"]
    }
    private var model: User?
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit(){
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: NSNotification.Name("LoginButtonDidTap"), object: nil)
        UserManager.singleton.getUserProfile { (user) in
            self.model = user
            self.tableView.reloadData()
        }
        contentView = Bundle.main.loadNibNamed("SideMenu", owner: self, options: nil)?.first! as? UIView
        contentView.frame = self.bounds
        self.addSubview(contentView)
        tableView.register(UINib(nibName: "LoginTableViewCell", bundle: nil), forCellReuseIdentifier: "LoginTableViewCell")
        tableView.register(UINib(nibName: "NotLoginTableViewCell", bundle: nil), forCellReuseIdentifier: "NotLoginTableViewCell")
    }
    @objc private func reloadTableView(){
        if UserManager.singleton.hasToken{
            UserManager.singleton.getUserProfile { user in
                self.model = user
                self.tableView.reloadData()
                print(user)
            }
            return
        }
        self.tableView.reloadData()
        
    }
}

extension SideMenu: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buttonName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        switch indexPath.row {
        case 0:
            print("Token : ", UserManager.singleton.hasToken)
            if UserManager.singleton.hasToken {
                let loginCell = tableView.dequeueReusableCell(withIdentifier: "LoginTableViewCell", for: indexPath) as! LoginTableViewCell
                loginCell.model = model
                loginCell.selectionStyle = .none
                return loginCell
            }else{
                cell = tableView.dequeueReusableCell(withIdentifier: "NotLoginTableViewCell", for: indexPath)
            }
        case 1:
            cell.textLabel?.text = "영화별 예매"
            cell.backgroundColor = .clear
            cell.textLabel?.textColor = .white
            cell.textLabel?.textAlignment = .center
        case 2:
            cell.textLabel?.text = "극장별 예매"
            cell.backgroundColor = .clear
            cell.textLabel?.textColor = .white
            cell.textLabel?.textAlignment = .center
        case 3:
            cell.textLabel?.text = "로그아웃"
            cell.backgroundColor = .clear
            cell.textLabel?.textColor = .white
            cell.textLabel?.textAlignment = .center
        default:
            break
        }
        cell.selectionStyle = .none
        return cell
    }
}

extension SideMenu: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: break
        case 1:
            // 영화별 예매
            MainViewController.showBookPage()
        case 2:
            // 극장별 예매 추후에 추가 
            MainViewController.showBookPage()
        case 3:
            // 로그아웃 함수호출
            UserManager.singleton.signOut(completion: {
                NotificationCenter.default.post(name: NSNotification.Name("LogoutBtnDidtap"), object: self)
                tableView.reloadData()
            })
            
        default:
            break
        }
    }
}

