//
//  Network.swift
//  AppSearchForRx
//
//  Created by hyunjun yang on 06/04/2019.
//  Copyright © 2019 hyunjun yang. All rights reserved.
//

import UIKit
import Moya

class Networking {
    let provider = MoyaProvider<SearchAppleRepo>()
    
    func AppleSearch(words term:String, completion: @escaping (SearchResponse) -> Void) {
        provider.request(.term(searchStr: term))  { result in
            switch result {
            case let .success(moyaResponse):
                print("Network Connection Success")
//                print(moyaResponse.data.base64EncodedString())
                let decoder = JSONDecoder()
                do {
                    let resultInfo = try decoder.decode(SearchResponse.self, from: moyaResponse.data)
                    print("JSON Parsing Success")
                    completion(resultInfo);
                } catch  {
                    print("JSON Parsing Fail")
                    print(error)
                }
            case let .failure(moyaError):
                //Network Fail Error
                print("Network Connection Error")
                print(moyaError)
            }
        }
    }
}
