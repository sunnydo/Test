//
//  NewsDetailViewController.swift
//  SpeedTest
//
//  Created by Sunny on 1/20/18.
//  Copyright © 2018 Sunny Do. All rights reserved.
//

import UIKit

class NewsDetailViewController: UIViewController {

    @IBOutlet weak var loadingView: SpringView!
    @IBOutlet weak var heightImageConstraint: NSLayoutConstraint!
    @IBOutlet weak var detailImage: UIImageView!
    var imageURL:String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadingView.showLoading()
        loadImage()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Image
    func loadImage () {
        if(imageURL == nil) {
            return
        }
        UIImageView.getImageFromURL(urlString: imageURL, completion: { (imageData) in
            let originImage:UIImage!
            if(imageData == nil) {
                originImage = UIImage(named:"pagenotfound")
            } else {
                originImage = UIImage(data: imageData!)!
            }
            
            //get ratio
            let ratio:CGFloat = UIScreen.main.bounds.width / originImage.size.width
            //-> height imagview
            let heightImageViewNew = ratio * originImage.size.height
            print(heightImageViewNew)
            DispatchQueue.main.async { [unowned self] in
                self.heightImageConstraint.constant = heightImageViewNew
                self.detailImage.image = originImage
                self.loadingView.hideLoading()
            }
            
        })
    }
    
    //MARK: - ACTION
    
    @IBAction func touchUpInsideBack(_ sender: UIButton) {
        self.navigationController!.popViewController(animated: true)
    }
}
