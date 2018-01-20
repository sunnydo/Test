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
            UIImageView.getImageFromURL(urlString: news.titleURLString!, completion: { (imageData) in
                let originImage:UIImage = UIImage(data: imageData!)!
                self.titleImage.image = originImage
            })
        }
    }
    @IBOutlet weak var titleImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
