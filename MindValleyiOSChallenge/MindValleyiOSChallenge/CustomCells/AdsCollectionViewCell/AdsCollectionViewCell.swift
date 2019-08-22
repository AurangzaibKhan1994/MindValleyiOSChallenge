//
//  AdsCollectionViewCell.swift
//  MindValleyiOSChallenge
//
//  Created by Aurangzaib on 19/08/2019.
//  Copyright © 2019 Aurangzaib. All rights reserved.
//

import UIKit

protocol DownloadImageDelegate {
    func downloadImageProgress(data: AdsCollectionViewCell)
}

class AdsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var adsView: UIView!
    @IBOutlet weak var imgVwAds: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblDownloadProgress: UILabel!
    @IBOutlet weak var btnDownloadImage: UIButton!
    @IBOutlet weak var downloadProgress: UIProgressView!
    
    var downloadImageDelegate: DownloadImageDelegate?
    var isAnimated = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func actionDownloadImage(_ sender: UIButton) {
        self.downloadImageDelegate?.downloadImageProgress(data: self)
    }
}
