//
//  MainViewModel.swift
//  AppSearchForRx
//
//  Created by hyunjun yang on 05/04/2019.
//  Copyright © 2019 hyunjun yang. All rights reserved.
//

import RxSwift
//import RxCocoa

class MainViewModel {
    let historyRepo = HistoryRepository()
    let searchRepo = SearchRepository()
    
    let historyData : Observable<[String]>
    let searchData : Observable<SearchResponse>
    let disposeBag = DisposeBag()
    
    init() {
        // rx init - output
        self.historyData = historyRepo.historyData.asObservable()
        self.searchData = searchRepo.searchData.asObservable()
    }
    
    func loadHistory() {
         historyRepo.loadHistoryData()
    }
    
    func search(text : String) {
        historyRepo.inputDataToDB(title: text)
        //Networing Search
        searchRepo.search(text: text)
    }
    
}
