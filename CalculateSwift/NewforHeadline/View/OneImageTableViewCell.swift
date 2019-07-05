//
//  OneImageTableViewCell.swift
//  BrowserSwift
//
//  Created by Wswy on 2019/5/28.
//  Copyright © 2019 王云晨. All rights reserved.
//

import UIKit

class OneImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var shouImageView: UIImageView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func getDateForServer(model:NewsModel) {
        self.titleLabel.text = model.titleString
        self.dateLabel.text = model.dateString
        let str = model.imageArray.first
        self.shouImageView?.sd_setImage(with: URL.init(string: str!), placeholderImage: UIImage.init(named: "timg"))
        if model.isRead {
            self.titleLabel.textColor = RGBCOLOR(r: 153, 153, 153)
        }   else {
            self.titleLabel.textColor = RGBCOLOR(r: 0, 0, 0)
        }
    }
}
