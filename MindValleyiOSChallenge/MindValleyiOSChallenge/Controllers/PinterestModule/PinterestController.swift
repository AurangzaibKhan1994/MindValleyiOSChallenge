//
//  PinterestController.swift
//  MindValleyiOSChallenge
//
//  Created by Aurangzaib on 23/08/2019.
//  Copyright © 2019 Aurangzaib. All rights reserved.
//

import UIKit
import LGRefreshView

class PinterestController: UIViewController, Storyboarded {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var coordinator: MainCoordinator?
    var pinterestData = [PinterestData]()
    var refreshView: LGRefreshView!
    var loadMoreData = false
    var items = [Int]()
    var image = UIImage()
    var limit = 0
    var total = Int()
    private let byteFormatter: ByteCountFormatter = {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useKB, .useMB]
        return formatter
    }()
    var totalBytesWritten = Int64()
    var totalBytesExpectedToWrite = Int64()
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPinterestData()
        createRefreshView()
        registeredNibs()
        
        // for collectionview dynamic layout according to images height
        if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        
        for i in 0...self.pinterestData.count{
            items.append(i)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }
    
    func registeredNibs()
    {
        collectionView.register(UINib(nibName: "AdsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AdsCollectionViewCell")
        collectionView.register(UINib(nibName: "CollectionViewLoadingCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewLoadingCell")
    }
    
    // to create pull to refresh
    func createRefreshView()
    {
        refreshView = LGRefreshView.init(scrollView: collectionView, refreshHandler: { ( ref ) in
            self.getPinterestData()
            self.refreshView.endRefreshing()
        })
        refreshView.tintColor = UIColor.purple
        refreshView.backgroundColor = UIColor.clear
    }
} // end class PinterestController

extension PinterestController: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        
        let imageUrlString = (self.pinterestData[indexPath.item] .urls?.small!)!
        let imageUrl = URL(string: imageUrlString)!
        let imageData = try? UIImage(withContentsOfUrl: imageUrl)
        let imageHeight = (imageData?.size.height) ?? 300.0
        return imageHeight
    }
}

extension PinterestController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        print("collectionView cell tapped")
    }
}

extension PinterestController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if section == 0 {
            return self.pinterestData.count // images // pinterestData
        } else if section == 1 && loadMoreData {
            return 1
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdsCollectionViewCell", for: indexPath) as! AdsCollectionViewCell
            
            cell.isAnimated = false
            cell.downloadImageDelegate = self
            if !cell.isAnimated {
                pinterestCellAnimation(pinterestCell: cell, indexPathRow: indexPath.row, shouldAnimate: cell.isAnimated)
            }
            
            //            cell.setAnimation(index: indexPath.row)
            let imageString = (self.pinterestData[indexPath.row].urls?.small!)!
            if imageString == ""{
                cell.btnDownloadImage.isHidden = true
            }else{
                cell.btnDownloadImage.isHidden = false
            }
            
            // loading Images from cache
            cell.imgVwAds.loadImagesFromCache(withUrl: imageString)
            cell.lblTitle.text = self.pinterestData[indexPath.row].user?.name ?? "Anonymous"
            cell.lblSubTitle.text = self.pinterestData[indexPath.row].categories?.first?.title ?? "No Title"
            cell.btnDownloadImage.tag = indexPath.row
            cell.btnDownloadImage.addTarget(self, action: #selector(downloadImage(sender:)), for: .touchUpInside)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewLoadingCell", for: indexPath) as! CollectionViewLoadingCell
            cell.spinner.startAnimating()
            return cell
        }
    }
}

extension PinterestController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:CGFloat(collectionView.frame.size.width * 0.46), height: collectionView.frame.size.height * 0.25)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

extension PinterestController{
    
    // to animate pinterest cell
    func pinterestCellAnimation(pinterestCell: AdsCollectionViewCell, indexPathRow: Int, shouldAnimate: Bool){
        UIView.animate(withDuration: 0.5, delay: 0.5 * Double(indexPathRow), usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: indexPathRow % 2 == 0 ? .transitionFlipFromLeft : .transitionFlipFromRight, animations: {
            
            if indexPathRow % 2 == 0 {
                AnimationUtility.viewSlideInFromLeft(toRight: pinterestCell)
            }else {
                AnimationUtility.viewSlideInFromRight(toLeft: pinterestCell)
            }
        }, completion: { (done) in
            pinterestCell.isAnimated = true
        })
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height * 4{
            if !loadMoreData {
                //                pagination()
                //                self.collectionView.reloadData()
            }
        }
    }
    
    // loading data in the set of 10
    func pagination() {
        loadMoreData = true
        print("pagination!")
        collectionView.reloadSections(IndexSet(integer: 1))
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            let newItems = (self.items.count...self.items.count + 10).map { index in index }
            self.items.append(contentsOf: newItems)
            self.loadMoreData = false
            //            self.collectionView.reloadData()
        })
    }
    
    //    func getPinterestData(){
    //        //        if animated{
    //        //            self.addGlobalHUDWith()
    //        //        }
    //        self.addGlobalHUDWith()
    //        APIClient.getPinterestData().ensure {
    //            self.hideGlobalHudAddedFromAppDelegate()
    //            }.done { (pinterestData) in
    //                print("PinterestData: ", pinterestData)
    //
    //            }.catch { (error) in
    //                if let backEndError = error as? BackEndError{
    //                    self.showAlertWith(title: backEndError.message.joined(), message: Constant.Alert.BackEnd.GenericError)
    //                }
    //        }
    //    }
    
    // getting data from API
    func getPinterestData(){
        self.addGlobalHUDWith()
        let params = [:] as Dictionary<String, String>
        var request = URLRequest(url: URL(string: "https://pastebin.com/raw/wgkJgazE")!)
        request.httpMethod = "GET"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            
            // checking the internet connection
            if !Connectivity.isConnectedToInternet{
                self.hideGlobalHudAddedFromAppDelegate()
                self.showAlertWith(title: "Alert", message: "No internet connection")
                return
            }
            
            if let res = response{
                print("Response", res)
                do {
                    let json = try JSONSerialization.jsonObject(with: data!) as! [[String:Any]]
                    let jsonData = try! JSONDecoder().decode([PinterestData].self, from: data!)
                    print(json)
                    print(jsonData) // update UI
                    self.pinterestData = jsonData
                    DispatchQueue.main.async {
                        self.hideGlobalHudAddedFromAppDelegate()
                        self.collectionView.reloadData()
                    }
                } catch {
                    print("error", error)
                }
            }else{
                self.hideGlobalHudAddedFromAppDelegate()
                print("error", error!)
            }
        })
        task.resume()
    }
    
    // downloading images to gallery // check the downloaded image in your phones gallery after this function is called completely
    @objc func downloadImage(sender: UIButton){
        print("Download image button pressed!")
        let imageString = (self.pinterestData[sender.tag].urls?.small!) ?? ""
        print("Image string to download", imageString)
        if imageString != "", let url = URL(string: imageString), let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
            DispatchQueue.main.async {
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            }
        }
    }
}

extension PinterestController: URLSessionDelegate, DownloadImageDelegate{
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let written = byteFormatter.string(fromByteCount: totalBytesWritten)
        let expected = byteFormatter.string(fromByteCount: totalBytesExpectedToWrite)
        print("Downloaded \(written) / \(expected)")
        
        DispatchQueue.main.async {
            self.totalBytesWritten = totalBytesWritten
            self.totalBytesExpectedToWrite = totalBytesExpectedToWrite
        }
    }
    
    func downloadImageProgress(data: AdsCollectionViewCell) {
        print("totalBytesWritten: \(self.totalBytesWritten), totalBytesExpectedToWrite: \(self.totalBytesExpectedToWrite)")
        data.lblDownloadProgress.isHidden = false
        data.downloadProgress.progress = Float(self.totalBytesWritten) / Float(self.totalBytesExpectedToWrite)
        data.lblDownloadProgress.text = String(Int(data.downloadProgress.progress * 100)) + "%"
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            data.downloadProgress.progress = Float(0)
            data.lblDownloadProgress.text = String(Int(data.downloadProgress.progress)) + "%"
            data.lblDownloadProgress.isHidden = true
        }
    }
}
