//
//  Speed.swift
//  SpeedTest
//
//  Created by Sunny Do on 19/01/2018.
//  Copyright © 2018 Sunny Do. All rights reserved.
//

import Foundation

class Speed {
    var domainString:String?
    var speedMs:String?
    init (dict:NSDictionary) {
        self.domainString = dict["DomainName"] as? String;
        self.speedMs = dict["Speed"] as? String;
    }
}
