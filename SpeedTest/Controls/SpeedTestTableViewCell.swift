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
            self.domainLabel.text = speedInfo?.domainString
            self.speedLabel.text = String(describing: speedInfo?.speedMs)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
