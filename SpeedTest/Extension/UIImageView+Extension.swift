//
//  UIImageView+Extension.swift
//  SpeedTest
//
//  Created by Sunny on 1/20/18.
//  Copyright © 2018 Sunny Do. All rights reserved.
//

import UIKit

extension UIImageView{
    class func getImageFromURL(urlString:String,completion:@escaping (_ imageData: Data? )->Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            //check existed file
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let documentDirectory = paths[0] as NSString
            //get file name in url
            let arr = urlString.split(separator: "/").map(String.init)
            let nameFile = arr[arr.count-1]
            
            let myFilePath = documentDirectory.appendingPathComponent(nameFile)
            
            let manager = FileManager.default
            if (manager.fileExists(atPath: myFilePath)) {
                // read file
                let data:Data = manager.contents(atPath: myFilePath)! as Data
                completion(data)
                return
            }else{
                let url = Foundation.URL(string: urlString)!
                let downloadTask: URLSessionDataTask = URLSession.shared.dataTask(with: url, completionHandler: { (data:Data?, response:URLResponse?, error:NSError?) in
                    if (error != nil) {
                        completion(nil)
                        return
                    }
                    if let data = data {
                        manager.createFile(atPath: myFilePath, contents: data, attributes: nil)
                        completion(data)
                        return
                    }
                    } as! (Data?, URLResponse?, Error?) -> Void)
                downloadTask.resume()
            }
        }
    }
}
