//
//  BooksModel.swift
//  APIProject
//
//  Created by WEMA on 18/01/2024.
//

import Foundation
import Realm
import RealmSwift


class BooksModel: Object, Codable{
    @Persisted var results: Results?
}

class Results: Object, Codable{
    @Persisted var books: List<BooksObj>
}

class BooksObj: Object, Codable{
    
    @Persisted var title: String?
    @Persisted var author: String?
    @Persisted var price: String?
    @Persisted var book_image: String?
    @Persisted var book_description: String?
    @Persisted var amazon_product_url: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case author = "author"
        case price = "price"
        case book_image = "book_image"
        case amazon_product_url = "amazon_product_url"
        case book_description = "description"
    }
}
