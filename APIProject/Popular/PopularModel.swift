//
//  PopularModel.swift
//  APIProject
//
//  Created by WEMA on 18/01/2024.
//

import Foundation
import Realm
import RealmSwift


class PopularModel: Object, Codable{
    @Persisted var results: List<PopularObj>
}

class PopularObj: Object, Codable{
    @Persisted var title: String?
    @Persisted var source: String?
    @Persisted var type: String?
    @Persisted var published_date: String?
    @Persisted var abstract: String?
}
