//
//  NotiRoomSearchViewController.swift
//  Noti
//
//  Created by 이채원 on 2016. 12. 1..
//  Copyright © 2016년 이채원. All rights reserved.
//

import Foundation
import UIKit

class NotiRoomSearchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var notiRoomSearchBar: UISearchBar!
    
    @IBOutlet var notiRoomTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.notiRoomTableView.delegate = self
        self.notiRoomTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotiRoomSearchViewCell", for: indexPath) as! NotiRoomSearchViewCell
        
        return cell
    }
}

class NotiRoomSearchViewCell: UITableViewCell {
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
