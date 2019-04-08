//
//  DBManager.swift
//  AppSearchForRx
//
//  Created by hyunjun yang on 05/04/2019.
//  Copyright © 2019 hyunjun yang. All rights reserved.
//

import Foundation
import RealmSwift

class DatabaseManager  {
    
    let realm : Realm
    
    init() {
        realm = try! Realm()
    }
    
    func writeDatabase(value : Object)  {
        try! realm.write {
            realm.add(value)
            print("Input Data is Succeed")
        }
    }
    
    func deleteDatabase(value : Object)  {
        try! realm.write {
            realm.delete(value)
            print("Delete Data is Succeed")
        }
    }
    
    func initializeDatabase()  {
        try! realm.write {
            realm.deleteAll()
            print("Delete All is Succeed")
        }
    }
    
    
    
}
