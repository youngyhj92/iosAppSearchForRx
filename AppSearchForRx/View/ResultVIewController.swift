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
    var searchController : UISearchController!
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
            if searchReesultData.resultCount == 0  {
                let cell = tableView.dequeueReusableCell(withIdentifier: "searchNone", for: indexPath) as! SearchResultNoneCell
                cell.searchWord.text = "'\(searchWord!)'"
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "searchResult", for: indexPath) as! SearchResultCell
                let appInfo = resultContents?[indexPath.row]
                let logoImageSet = RoundCornerImageProcessor(cornerRadius: 20)
                cell.logoImage.kf.setImage(with:appInfo!.artworkUrl100,options:[.processor(logoImageSet)])
                cell.appTitle.text = appInfo!.trackName
                cell.appCategory.text = appInfo!.primaryGenreName
                cell.appRating.text = appInfo!.trackContentRating
                return cell
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.isSearching  {
            searchController.searchBar.text = filteredResult[indexPath.row]
            viewModel.search(text: searchController.searchBar.text!)
            self.isSearching = false
//            self.tableView.reloadData()
        } else {
            print("clicked")
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
    @IBOutlet weak var logoImage: UIImageView!
    
}
