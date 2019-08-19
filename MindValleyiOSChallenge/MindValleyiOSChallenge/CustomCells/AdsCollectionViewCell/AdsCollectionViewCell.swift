//
//  AdsCollectionViewCell.swift
//  MindValleyiOSChallenge
//
//  Created by Aurangzaib on 19/08/2019.
//  Copyright © 2019 Aurangzaib. All rights reserved.
//

import UIKit

class AdsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var adsView: UIView! //BaseUIView!
    @IBOutlet weak var imgVwAds: UIImageView!
    @IBOutlet weak var lblTitle: UILabel! //BaseUILabel!
    @IBOutlet weak var lblSubTitle: UILabel! //BaseUILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

//        containerView.layer.cornerRadius = 6
//        containerView.layer.masksToBounds = true
    }

    var photo: Photo? {
        didSet {
            if let photo = photo {
                imgVwAds.image = photo.image
                lblTitle.text = photo.caption
                lblSubTitle.text = photo.comment
            }
        }
    }
}
