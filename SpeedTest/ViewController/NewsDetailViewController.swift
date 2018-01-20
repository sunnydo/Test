//
//  NewsDetailViewController.swift
//  SpeedTest
//
//  Created by Sunny on 1/20/18.
//  Copyright © 2018 Sunny Do. All rights reserved.
//

import UIKit

class NewsDetailViewController: UIViewController {

    @IBOutlet weak var heightImageConstraint: NSLayoutConstraint!
    @IBOutlet weak var detailImage: UIImageView!
    var imageURL:String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Image
    func loadImage () {
        UIImageView.getImageFromURL(urlString: imageURL, completion: { (imageData) in
            let originImage:UIImage = UIImage(data: imageData!)!
            //get ratio
            let ratio:CGFloat = UIScreen.main.bounds.width / originImage.size.width
            //-> height imagview
            let heightImageViewNew = ratio * originImage.size.height
            print(heightImageViewNew)
            self.heightImageConstraint.constant = heightImageViewNew
            
        })
    }
    
    //MARK: - ACTION
    
    @IBAction func touchUpInsideBack(_ sender: UIButton) {
        self.navigationController!.popViewController(animated: true)
    }
}
