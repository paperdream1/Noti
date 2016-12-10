//
//  ChannelAddController.swift
//  Noti
//
//  Created by 황정보 on 2016. 11. 8..
//  Copyright © 2016년 이채원. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ChannelAddController : UIViewController
{
    var ref:FIRDatabaseReference!
    var user:FIRUser!
    
    @IBOutlet weak var channelTextField: UITextField!
    
    func setup(){
        self.ref = FIRDatabase.database().reference()
        self.user = FIRAuth.auth()?.currentUser
    }
    
    func addChannel(){
        let key = ref.child("joinin").childByAutoId().key
        
        let channelItem = ["userid" : self.user.uid,
                           "channelid" : ]
        
        
    }
    
    

    
}
