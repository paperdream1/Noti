//
//  Channel.swift
//  Noti
//
//  Created by 이채원 on 2016. 11. 8..
//  Copyright © 2016년 이채원. All rights reserved.
//

internal class Channel {
    internal let id: String
    internal let name: String
    internal let about: String
    
    init(id: String, name: String, about:String) {
        self.id = id
        self.name = name
        self.about = about
    }
}
