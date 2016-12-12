//
//  RoomDetailViewController.swift
//  Noti
//
//  Created by 이채원 on 2016. 12. 12..
//  Copyright © 2016년 이채원. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class RoomDetailViewController: UIViewController {
    
    var channel:Channel?
    
    private var relationRef: FIRDatabaseReference = FIRDatabase.database().reference().child("relation")
    private var relationRefHandle: FIRDatabaseHandle?
    
    @IBOutlet var detailImageView: UIImageView!
    
    @IBOutlet var roomNameLabel: UILabel!
    
    @IBOutlet var roomInfoLabel: UILabel!
    
    @IBAction func whenJoinButtonClicked(_ sender: Any) {
        let currentUser = FIRAuth.auth()?.currentUser
        
        let newRelationRef = relationRef.child((currentUser?.uid)!)
        
        var relationItem = [
            channel?.id
        ]
        
        for room in MyNotiRoomController.rooms
        {
            if(channel?.id == room.id)
            {
                let alertView = UIAlertController(title: "이미 가입된 공지방입니다", message: "", preferredStyle: UIAlertControllerStyle.alert)
                let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                alertView.addAction(alertAction)
                self.present(alertView, animated: true, completion: nil)
                
                return
            }
            relationItem.append(room.id)
        }
        
        newRelationRef.setValue(relationItem)
        
        let alertView = UIAlertController(title: "공지방에 가입되었습니다", message: "", preferredStyle: UIAlertControllerStyle.alert)
        let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alertView.addAction(alertAction)
        self.present(alertView, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roomNameLabel.text = channel?.name
        roomInfoLabel.text = channel?.about
    }
}
