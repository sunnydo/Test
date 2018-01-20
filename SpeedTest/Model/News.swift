//
//  News.swift
//  SpeedTest
//
//  Created by Sunny on 1/20/18.
//  Copyright © 2018 Sunny Do. All rights reserved.
//

import Foundation

class News {
    var titleURLString:String?
    var contentURLString:String?
    
    init(dict:NSDictionary) {
        self.titleURLString = dict["Title"] as?String
        self.contentURLString = dict["Content"] as?String
    }
}
