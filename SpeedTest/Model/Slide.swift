//
//  Slide.swift
//  SpeedTest
//
//  Created by Sunny on 1/20/18.
//  Copyright © 2018 Sunny Do. All rights reserved.
//

import Foundation

class Slide {
    var sideURLString: String?
    init(dict:NSDictionary) {
        self.sideURLString = dict["Url"] as? String
    }
}
