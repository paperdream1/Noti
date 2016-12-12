//
//  SideBarController.swift
//  Noti
//
//  Created by 이채원 on 2016. 12. 12..
//  Copyright © 2016년 이채원. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class SideBarController: UIViewController {
    
    @IBOutlet var id: UILabel!
    @IBOutlet var logoutButton: UIButton!
    @IBOutlet var profileImageView: UIImageView!
    
    
    @IBAction func whenLogout(_ sender: Any) {
        
        do {
            try FIRAuth.auth()?.signOut()
            
            self.dismiss(animated: true, completion: nil)
        } catch {
            let alertView = UIAlertController(title: "로그아웃 실패", message: "", preferredStyle: UIAlertControllerStyle.alert)
            let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
            
            return
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.layer.cornerRadius=profileImageView.frame.height/2
        profileImageView.clipsToBounds=true
                
        id.text = FIRAuth.auth()?.currentUser?.email
        
        logoutButton.layer.borderColor = UIColor.black.cgColor
        logoutButton.layer.borderWidth = 2
    }
}
