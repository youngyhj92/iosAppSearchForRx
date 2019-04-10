//
//  ViewController.swift
//  AppSearchForRx
//
//  Created by hyunjun yang on 05/04/2019.
//  Copyright © 2019 hyunjun yang. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController : UITableViewController {
    private var searchController : UISearchController!
    private var searchResultVC : ResultViewController!
    
    let viewModel = MainViewModel()
    let disposeBag = DisposeBag()
    
    var historyList = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchController()
        rxDataInit()
        viewModel.loadHistory()
    }
    
    private func setSearchController() {
        searchResultVC = ResultViewController()
        searchResultVC.tableView.delegate = self
        searchController = UISearchController(searchResultsController: searchResultVC)
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        if #available(iOS 11.0, *) {
            // For iOS 11 and later, place the search bar in the navigation bar.
            navigationItem.searchController = searchController
            // Make the search bar always visible.
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            // For iOS 10 and earlier, place the search controller's search bar in the table view's header.
            tableView.tableHeaderView = searchController.searchBar
        }
        searchController.delegate = self
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.delegate = self
        definesPresentationContext = true
    
    }
    
    private func rxDataInit()  {
        viewModel.historyData.subscribe({ event in
            guard let elementData = event.element else {
                self.historyList = ["No data"]
                return
            }
            self.historyList = elementData
            self.tableView.reloadData()
        })
        .disposed(by: disposeBag)
        
        viewModel.searchData.subscribe { event in
            guard let responseData = event.element else {
                return
            }
            self.searchResultVC.searchReesultData = responseData
            self.searchResultVC.tableView.reloadData()
        }
        .disposed(by: disposeBag)
        
        // searchBar searching
        searchController.searchBar.rx.text
            .subscribe  { event in
                guard let searchBarText = event.element else {
                    return
                }
                self.searchResultVC.searchWord = searchBarText
            
                self.searchResultVC.filteredResult = searchBarText!.isEmpty ? self.historyList : self.historyList.filter({ (data:String) -> Bool in
                    return data.range(of: searchBarText!, options:.caseInsensitive) != nil
                })
                self.searchResultVC.tableView.reloadData()
        }
        .disposed(by: disposeBag)
        
        
    }
}

//HistoryView
extension MainViewController  {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let maxLine = 7
        if historyList.count > maxLine  {
            return maxLine
        } else {
            return historyList.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyTableViewCell") as! HistoryTableViewCell
        cell.historyCell.text = historyList[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.searchController.isActive == false  {
            self.searchController.isActive = true
            self.searchController.searchBar.text = historyList[indexPath.row]
            searchBarSearchButtonClicked(self.searchController.searchBar)
        }  else {
            if searchResultVC.isSearching == true  {
                searchController.searchBar.text = searchResultVC.filteredResult[indexPath.row]
                searchBarSearchButtonClicked(searchController.searchBar)
            }  else {
                guard let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "appDetailInfoView") as? DetailViewController else {
                    print("err")
                    return
                }
                
                detailVC.detailInfo = searchResultVC.resultContents?[indexPath.row]
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
        }
        
    }
}

class HistoryTableViewCell : UITableViewCell  {
    @IBOutlet weak var historyCell: UILabel!
}

extension MainViewController : UISearchControllerDelegate {
    
}

extension MainViewController : UISearchBarDelegate  {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchResultVC.isSearching = false
        guard let searchingText = searchBar.text else {
            print("searching text is empty")
            return
        }
        viewModel.search(text: searchingText)
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchResultVC.isSearching = false
        viewModel.loadHistory()
    }
}

extension MainViewController : UISearchResultsUpdating  {
    func updateSearchResults(for searchController: UISearchController) {
        searchResultVC.isSearching = true
        searchResultVC.searchWord = searchController.searchBar.text
//        viewModel.loadHistory()
    }
}
