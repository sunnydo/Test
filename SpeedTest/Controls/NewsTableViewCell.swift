//
//  NewsTableViewCell.swift
//  SpeedTest
//
//  Created by Sunny Do on 19/01/2018.
//  Copyright © 2018 Sunny Do. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    var news:News! {
        didSet {
            if let url  = news.titleURLString {
                loadingIndicator.startAnimating()
                UIImageView.getImageFromURL(urlString: url, completion: { (imageData) in
                   DispatchQueue.main.async { [unowned self] in self.loadingIndicator.stopAnimating()
                        if let data = imageData{
                            self.titleImage.image = UIImage(data: data)
                        } else {
                            self.titleImage.image = UIImage(named:"pagenotfound")
                        }
                    }
                })
            } else {
                self.loadingIndicator.stopAnimating()
                self.titleImage.image = UIImage(named:"pagenotfound")
            }
        }
    }
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
