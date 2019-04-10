//
//  ResultVIew.swift
//  AppSearchForRx
//
//  Created by hyunjun yang on 05/04/2019.
//  Copyright © 2019 hyunjun yang. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Kingfisher

class ResultViewController : UITableViewController  {
    
    var isSearching = false
    let viewModel = ResultViewModel()
    let disposeBag = DisposeBag()
    
    var searchWord : String? = ""
    var filteredResult = [String]()
    var searchReesultData = SearchResponse(resultCount:-1, results:nil)
    lazy var resultContents : [AppInformation]? = {
        return searchReesultData.results
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
        rxDataInit()
    }
    
    private func registerNib() {
        let searchingNib = UINib(nibName: "SearchListCell", bundle: nil)
        tableView.register(searchingNib, forCellReuseIdentifier: "searchList")
        
        let searchedNib = UINib(nibName: "SearchResultCell", bundle: nil)
        tableView.register(searchedNib, forCellReuseIdentifier: "searchResult")
        
        let searchedNoneNib = UINib(nibName: "SearchNoneCell", bundle: nil)
        tableView.register(searchedNoneNib, forCellReuseIdentifier: "searchNone")
        
        tableView.separatorStyle = .none
    }
    
    private func rxDataInit() {
        viewModel.searchData.subscribe { response in
            guard let data = response.element else {
                return
            }
            self.searchReesultData = data
            self.tableView.reloadData()
        }
        .disposed(by: disposeBag)
    }
}

extension ResultViewController  {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isSearching {
            return filteredResult.count
        } else {
            if searchReesultData.resultCount == 0{
                return 1
            }  else  {
                return searchReesultData.resultCount
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.isSearching {
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchList", for: indexPath)
            cell.textLabel?.text = filteredResult[indexPath.row]
            return cell
        } else {
            let appInfo = resultContents?[indexPath.row]
            if appInfo == nil  {
                let cell = tableView.dequeueReusableCell(withIdentifier: "searchNone", for: indexPath) as! SearchResultNoneCell
                cell.searchWord.text = "'\(searchWord!)'"
                return cell
            }  else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "searchResult", for: indexPath) as! SearchResultCell
                let logoImageSet = RoundCornerImageProcessor(cornerRadius: 20)
                cell.logoImageView.kf.setImage(with:appInfo!.artworkUrl100,options:[.processor(logoImageSet)])
                cell.appTitle.text = appInfo!.trackName
                cell.appCategory.text = appInfo!.primaryGenreName
                cell.appRating.text = appInfo!.trackContentRating
                
                guard let screenshots = appInfo?.screenshotUrls else {
                    return cell
                }
                let screenshotImageSet = RoundCornerImageProcessor(cornerRadius: 50)
                switch screenshots.count  {
                    case 1:
                        cell.firstScreenShot.kf.setImage(with: screenshots[0], options:[.processor(screenshotImageSet)])
                        cell.secondScreenShot.isHidden = true
                        cell.thirdScreenShot.isHidden = true
                        break
                    case 2:
                        cell.firstScreenShot.kf.setImage(with: screenshots[0], options:[.processor(screenshotImageSet)])
                        cell.secondScreenShot.kf.setImage(with: screenshots[1], options:[.processor(screenshotImageSet)])
                        cell.thirdScreenShot.isHidden = true
                        break
                    case 0:
                        cell.firstScreenShot.isHidden = true
                        cell.secondScreenShot.isHidden = true
                        cell.thirdScreenShot.isHidden = true
                        break
                    default:
                        cell.firstScreenShot.kf.setImage(with: screenshots[0], options:[.processor(screenshotImageSet)])
                        cell.secondScreenShot.kf.setImage(with: screenshots[1], options:[.processor(screenshotImageSet)])
                        cell.thirdScreenShot.kf.setImage(with: screenshots[2], options:[.processor(screenshotImageSet)])
                        break
                    }
                return cell
                }
            }
        }
}

class SearchResultNoneCell : UITableViewCell  {
    @IBOutlet weak var searchWord: UILabel!
}

class SearchResultCell : UITableViewCell  {
    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var appCategory: UILabel!
    @IBOutlet weak var appRating: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    

    @IBOutlet weak var firstScreenShot: UIImageView!
    @IBOutlet weak var secondScreenShot: UIImageView!
    @IBOutlet weak var thirdScreenShot: UIImageView!
    
}
