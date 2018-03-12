//
//  ServerAPI.swift
//  SpeedTest
//
//  Created by Sunny on 1/20/18.
//  Copyright © 2018 Sunny Do. All rights reserved.
//

import Foundation
import Alamofire
import ImageSlideshow

class ServerAPI {
    class var shared : ServerAPI {
        struct Static {
            static let instance : ServerAPI = ServerAPI()
        }
        return Static.instance
    }
    
    let serverDomain = "http://fa66.me/"
    let apiUpdatedNews = "api/SpeedTest/UpdatedNews"
    let apiSpeed = "api/SpeedTest/GetDomains"
    let apiNews = "api/SpeedTest/GetNews"
    let apiSlide = "api/SpeedTest/GetSlides"
    
    
    func getDictionaryFromURL(url:String,completion:@escaping (_ dict: NSDictionary,_ failure:Bool )->Void) {
        
        Alamofire.request(url, method: .get, parameters: [:], encoding: URLEncoding.default)
            .responseJSON { response in
                print(response)
                //to get JSON return value
                if let result = response.result.value {
                    let JSON = self.convertToDictionary(text: (result as! String))
                    completion(JSON!,false)
                }
        }
    }
    
    func getUpdatedAPI (completion:@escaping (_ isUpdated:Bool) -> Void) {
        let url:String = serverDomain + apiUpdatedNews
        getDictionaryFromURL(url: url) { (dict:NSDictionary!, failure:Bool!) in
            if(!failure) {
                let r:NSDictionary = dict["Content"] as!NSDictionary
                let boolStr:String = (r["IsUpdated"] as? String)!
                if(boolStr == "true") {
                    completion(true)
                } else {
                    completion(false)
                }
                
            }
        }
    }
    
    func getSlideAPI (completion:@escaping (_ slides:[AlamofireSource]) -> Void) {
        let url:String = serverDomain + apiSlide
        var slideObjects:[AlamofireSource] = [];
        getDictionaryFromURL(url: url) { (dict:NSDictionary!, failure:Bool!) in
            if(!failure) {
                let slides:[NSDictionary] = dict["Content"] as! [NSDictionary]
                for s:NSDictionary in slides {
                    let slide:Slide = Slide(dict:s)
                    //convert to alamore fire
                    slideObjects.append(AlamofireSource(urlString:slide.sideURLString!)!)
                }
                completion(slideObjects)
            }
        }
    }
    
    func getSpeedAPI (completion:@escaping (_ slides:[Speed]) -> Void) {
        let url:String = serverDomain + apiSpeed
        var speedObjects:[Speed] = [];
        getDictionaryFromURL(url: url) { (dict:NSDictionary!, failure:Bool!) in
            let speeds:[NSDictionary] = dict["Content"] as! [NSDictionary]
            for s:NSDictionary in speeds {
                let speedObject:Speed = Speed(dict:s)
                if( speedObject.domainString != nil  ) {
                    speedObjects.append(speedObject)
                }
            }
            completion(speedObjects)
        }
    }
    
    func getNewsAPI (completion:@escaping (_ slides:[News]) -> Void) {
        let url:String = serverDomain + apiNews
        var newsObjects:[News] = [];
        getDictionaryFromURL(url: url) { (dict:NSDictionary!, failure:Bool!) in
            let speeds:[NSDictionary] = dict["Content"] as! [NSDictionary]
            for s:NSDictionary in speeds {
                let newsObject:News = News(dict:s)
                newsObjects.append(newsObject)
            }
            completion(newsObjects)
        }
    }
    
    func convertToDictionary(text: String) -> NSDictionary? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

}



