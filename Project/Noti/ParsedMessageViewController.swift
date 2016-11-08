//
//  ParsedMessageViewController.swift
//  Noti
//
//  Created by 이채원 on 2016. 11. 3..
//  Copyright © 2016년 이채원. All rights reserved.
//

import Foundation
import UIKit

class ParsedMessageController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    
    var originalMessage:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.text = originalMessage
    }
}
