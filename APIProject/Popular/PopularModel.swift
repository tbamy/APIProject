//
//  PopularModel.swift
//  APIProject
//
//  Created by WEMA on 18/01/2024.
//

import Foundation
struct PopularModel: Codable{
    let results: [PopularObj]?
}

struct PopularObj: Codable{
    let title: String?
    let source: String?
    let type: String?
    let published_date: String?
    
    let abstract: String?
}
