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
    
    var isFirstTime = true
    var isAnimated = false

    override func awakeFromNib() {
        super.awakeFromNib()

//        containerView.layer.cornerRadius = 6
//        containerView.layer.masksToBounds = true
    }

//    var photo: Photo? {
//        didSet {
//            if let photo = photo {
//                imgVwAds.image = photo.image
//                lblTitle.text = photo.caption
//                lblSubTitle.text = photo.comment
//            }
//        }
//    }
    
    func setupForAnimation()
    {
        imgVwAds.isHidden = true
        lblTitle.isHidden = true
        lblSubTitle.isHidden = true
    }
    
    @objc func animate()
    {
        perform(#selector(flipImgAd), with: nil, afterDelay: 0.0)
        perform(#selector(fliplblAd), with: nil, afterDelay: 0.1)
        perform(#selector(fliplblAdDescription), with: nil, afterDelay: 0.2)
    }
    
    @objc func flipImgAd()
    {
        imgVwAds.flipFromRight()
    }
    
    @objc func fliplblAd()
    {
        lblTitle.flipFromRight()
    }
    
    @objc func fliplblAdDescription()
    {
        lblSubTitle.flipFromRight()
    }
    
    func setAnimation(index: Int)
    {
        if index < 4 && isFirstTime
        {
            setupForAnimation()
            perform(#selector(animate), with: nil, afterDelay: 0.2)
            isFirstTime = false
        }
    }
}
