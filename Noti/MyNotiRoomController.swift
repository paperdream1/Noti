//
//  MyNotiRoomController.swift
//  Noti
//
//  Created by 이채원 on 2016. 11. 2..
//  Copyright © 2016년 이채원. All rights reserved.
//

import Foundation
import UIKit

class MyNotiRoomController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyNotiRoomCell", for: indexPath) as! MyNotiRoomCell
        
        return cell
    }
}

class MyNotiRoomCell: UITableViewCell {
    
    @IBOutlet var roomLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
