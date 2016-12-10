//
//  ChannelAddController.swift
//  Noti
//
//  Created by 황정보 on 2016. 11. 8..
//  Copyright © 2016년 이채원. All rights reserved.
//

import Foundation
import UIKit

class ChannelAddController : UIViewController
{

    
    @IBOutlet weak var channelTextField: UITextField!
    
    @IBOutlet var aboutTextField: UITextField!

    @IBAction func cancleButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
