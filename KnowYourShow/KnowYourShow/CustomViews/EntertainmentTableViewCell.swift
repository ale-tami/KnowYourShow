//
//  EntertainmentTableViewCell.swift
//  KnowYourMovie
//
//  Created by Alejandro Cesar Tami on 22/07/2019.
//  Copyright © 2019 Alejandro Cesar Tami. All rights reserved.
//

import UIKit
import Kingfisher

class EntertainmentTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setImage(with url:URL?) {
        if let img = url  {
            let resource = ImageResource(downloadURL: img)
            self.posterImageView.kf.indicatorType = .activity
            self.posterImageView.kf.setImage(with: resource)
        }
    }
   
}
