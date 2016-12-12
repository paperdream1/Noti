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
            relationItem.append(room.id)
        }
        
        newRelationRef.setValue(relationItem)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roomNameLabel.text = channel?.name
        roomInfoLabel.text = channel?.about
    }
}
