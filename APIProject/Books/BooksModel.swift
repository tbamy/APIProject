//
//  BooksModel.swift
//  APIProject
//
//  Created by WEMA on 18/01/2024.
//

import Foundation

struct BooksModel: Codable{
    let results: Results?
}

struct Results: Codable{
    let books: [BooksObj]?
}

struct BooksObj: Codable{
    
    let title: String?
    let author: String?
    let price: String?
    let book_image: String?
    let description: String?
    let amazon_product_url: String?
}
