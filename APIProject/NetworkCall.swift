//
//  Popular.swift
//  APIProject
//
//  Created by WEMA on 18/01/2024.
//

import Foundation

class NetworkCall{
    let session = URLSession.shared
    func PopularFetch(url: URL) async throws -> PopularModel? {
        do{
            let (data, _) = try await session.data(from: url)
            let jsonDecoder = JSONDecoder()
            let popularModel = try jsonDecoder.decode(PopularModel.self, from: data)
            return popularModel
        }catch{
            throw error
        }
    }
    
    func BooksFetch(url: URL) async throws -> BooksModel? {
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
