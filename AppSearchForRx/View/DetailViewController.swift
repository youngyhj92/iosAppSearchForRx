//
//  DetailViewController.swift
//  AppSearchForRx
//
//  Created by 양현준 on 08/04/2019.
//  Copyright © 2019 hyunjun yang. All rights reserved.
//

import UIKit
import Kingfisher

class DetailViewController : UIViewController  {
    
    var detailInfo : AppInformation?
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var sellerName: UILabel!
    @IBOutlet weak var rating: UILabel!
    
    @IBOutlet weak var screenshotView: UICollectionView!
    @IBOutlet weak var descriptionContents: UILabel!
    @IBOutlet weak var releaseNoteContents: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "App Information"
        screenshotView.dataSource = self
        
        guard let appInfo = self.detailInfo else {
            return
        }
        showAppInfo(info : appInfo)
    }
    
    private func showAppInfo(info : AppInformation)  {
        let logoImageSet = RoundCornerImageProcessor(cornerRadius: 20)
        self.logoImage.kf.setImage(with: info.artworkUrl100, options:[.processor(logoImageSet)])
        self.appName.text = info.trackName
        self.category.text = info.genres?[0]
        self.sellerName.text = info.artistName
        self.rating.text = info.trackContentRating
        self.descriptionContents.text = info.description
        self.releaseNoteContents.text = info.releaseNotes
        
    }
    
    @IBAction func test(_ sender: UIButton) {
    }
    @IBAction func descriptionMoreClick(_ moreButton : UIButton) {
        self.descriptionContents.numberOfLines = 100
        self.descriptionContents.reloadInputViews()
        moreButton.isHidden = true
    }
    @IBAction func releaseNoteMoreClick(_ moreButton: UIButton) {
        self.releaseNoteContents.numberOfLines = 100
        self.descriptionContents.reloadInputViews()
        moreButton.isHidden = true
    }
    
}



extension DetailViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let screenshotUrl = detailInfo?.screenshotUrls else {
            return 0
        }
        return screenshotUrl.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let screenshotImageSet = RoundCornerImageProcessor(cornerRadius: 50)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "screenshotCell", for: indexPath) as! ScreenshotViewCell
        cell.screenshot.kf.setImage(with: detailInfo?.screenshotUrls?[indexPath.item])
        
        return cell
    }
    
    
}

class ScreenshotViewCell : UICollectionViewCell  {
    @IBOutlet weak var screenshot: UIImageView!
    
}

