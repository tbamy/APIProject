//
//  BooksViewModel.swift
//  APIProject
//
//  Created by TBAM on 21/01/2024.
//

import Foundation

protocol BooksViewModelDelegate: AnyObject {
    func didReceiveResponse(data: BooksModel?)
    func didReceiveError(error: String)
}

class BooksViewModel {
    
    var networkCall: NetworkCall
    
    init(networkCall: NetworkCall) {
        self.networkCall = networkCall
    }
    
    weak var delegate: BooksViewModelDelegate?
    
    var responseHandler: ((BooksModel?) -> Void)?
    var errorHandler: ((String?) -> Void)?
    
    func fetchBooks() async {
        do {
            let booksModel = try await networkCall.BooksFetch(url: URL(string: "https://api.nytimes.com/svc/books/v3/lists/current/hardcover-fiction.json?api-key=WKHndJGECQsOKf2XYga2eyWRsDCygmdN")!)
            responseHandler?(booksModel)
        } catch let error {
            errorHandler?(error.localizedDescription)
        }
    }
}

// To Test BooksViewModel
//class MockNetworkService: NetworkCall {
//    
//    override func BooksFetch(url: URL) async throws -> BooksModel? {
//        return BooksModel(results: [])
//    }
//}

//let booksViewModel = BooksViewModel(networkCall: MockNetworkService())

