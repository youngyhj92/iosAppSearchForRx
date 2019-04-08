//
//  ResultViewModel.swift
//  AppSearchForRx
//
//  Created by hyunjun yang on 06/04/2019.
//  Copyright © 2019 hyunjun yang. All rights reserved.
//

import RxSwift

class ResultViewModel  {
    let historyRepo = HistoryRepository()
    let searchRepo = SearchRepository()
    
    let historyData : Observable<[String]>
    let searchData : Observable<SearchResponse>
    let disposeBag = DisposeBag()
    
    init() {
        self.historyData = historyRepo.historyData.asObservable()
        self.searchData = searchRepo.searchData.asObservable()
    }
    
    func search(text : String) {
        historyRepo.inputDataToDB(title: text)
        //Networing Search
        searchRepo.search(text: text)
    }
}
