//
//  AdsCollectionViewCell.swift
//  MindValleyiOSChallenge
//
//  Created by Aurangzaib on 19/08/2019.
//  Copyright © 2019 Aurangzaib. All rights reserved.
//

import UIKit

class AdsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var adsView: UIView!
    @IBOutlet weak var imgVwAds: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    
    var isAnimated = false

    override func awakeFromNib() {
        super.awakeFromNib()

    }
}
