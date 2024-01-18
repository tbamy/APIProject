//
//  Books.swift
//  APIProject
//
//  Created by WEMA on 18/01/2024.
//

import Foundation

struct Books{
    let session = URLSession.shared
    func fetch(url: URL) async throws -> BooksModel? {
        do{
            let (data, _) = try await session.data(from: url)
            let jsonDecoder = JSONDecoder()
            let booksModel = try jsonDecoder.decode(BooksModel.self, from: data)
            return booksModel
        }catch{
            throw error
        }
    }
    
}
