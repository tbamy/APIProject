//
//  RealmHelper.swift
//  APIProject
//
//  Created by TBAM on 24/01/2024.
//

import Foundation
import Realm
import RealmSwift

class RealmHelper{
    static let shared = RealmHelper()
    private init(){}
    
    var realm: Realm{
        let realm = try! Realm()
        
        return realm
    }
}
