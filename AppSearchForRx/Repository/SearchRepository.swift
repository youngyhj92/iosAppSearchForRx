//
//  SearchRepository.swift
//  AppSearchForRx
//
//  Created by hyunjun yang on 06/04/2019.
//  Copyright © 2019 hyunjun yang. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SearchRepository  {
    let network = Networking()
    var searchData = PublishSubject<SearchResponse>()
    
    func search(text : String)  {
        network.AppleSearch(words: text) { response in
            self.searchData.onNext(response)
            print(response.resultCount)
        }
    }
}
