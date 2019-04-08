//
//  HistoryRepository.swift
//  AppSearchForRx
//
//  Created by hyunjun yang on 06/04/2019.
//  Copyright © 2019 hyunjun yang. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class HistoryRepository  {
    let dbManager = DatabaseManager()
    var historyData = PublishSubject<[String]>()
    
    func inputDataToDB(title : String) {
        let data = History()
        data.historyTitle = title
        dbManager.writeDatabase(value: data)
    }
    
    func loadHistoryData() {
        let dbData = dbManager.realm.objects(History.self).distinct(by: ["historyTitle"])
        var returnData = [String]()
        if dbData.isEmpty  {
            print("Empty")
        } else {
            for index in stride(from: dbData.count - 1, to: -1, by: -1)  {
                returnData.append(dbData[index].historyTitle)
            }
            print(returnData)
        }
        
        historyData.on(.next(returnData))
    }
    
}
