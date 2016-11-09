//
//  Messege.swift
//  Noti
//
//  Created by 황정보 on 2016. 11. 1..
//  Copyright © 2016년 이채원. All rights reserved.
//

import Foundation

class Messege{
    var id:String?
    var text:String?
    var date:Date?
    var name:String?
    
    init (id:String, name:String, text:String, date:Date){
        self.id = id
        self.name = name
        self.text = text
        self.date = date
    }
}
