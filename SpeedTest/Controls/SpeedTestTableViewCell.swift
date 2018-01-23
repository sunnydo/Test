//
//  SpeedTestTableViewCell.swift
//  SpeedTest
//
//  Created by Sunny Do on 19/01/2018.
//  Copyright © 2018 Sunny Do. All rights reserved.
//

import UIKit

class SpeedTestTableViewCell: UITableViewCell {

    //outlet
    @IBOutlet weak var domainLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var openButton: UIButton!
    
    var speedInfo:Speed? {
        didSet {
            if let domain = speedInfo?.domainString {
                self.domainLabel.text = domain
            }
            if let ms = speedInfo?.speedMs {
                self.speedLabel.text = ms
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        domainLabel.layer.masksToBounds = true
        speedLabel.layer.masksToBounds = true
        openButton.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func touchUpInsideOpen(_ sender: UIButton) {
        if let url = URL(string:(speedInfo?.domainString)!) {
            UIApplication.shared.openURL(url)
        }
    }
}
