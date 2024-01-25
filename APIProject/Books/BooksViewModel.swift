//
//  BooksViewModel.swift
//  APIProject
//
//  Created by TBAM on 21/01/2024.
//
import Foundation
import RealmSwift


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
    
    @MainActor
    func fetchBooks() async {
        do {
//            try RealmHelper.shared.realm.write({
//                RealmHelper.shared.realm.deleteAll()
//                    print("Deleted Succesfully")
//                })

            if let storedInformation = RealmHelper.shared.realm.objects(BooksModel.self).first {
                delegate?.didReceiveResponse(data: storedInformation)
//                responseHandler?(storedInformation)
//                print(storedInformation)
                print("Response from Realm")
            } else {
                let booksModel = try await networkCall.BooksFetch(url: URL(string: "https://api.nytimes.com/svc/books/v3/lists/current/hardcover-fiction.json?api-key=WKHndJGECQsOKf2XYga2eyWRsDCygmdN")!)
                
                    if let booksResult = booksModel{
                    
                   try RealmHelper.shared.realm.write({
                        RealmHelper.shared.realm.add(booksResult)
                       delegate?.didReceiveResponse(data: booksResult)
//                        self.responseHandler?(booksResult)
                            print("Response from API")
//                            print(booksResult)
                    })
                        
                }
                
            }
            
        } catch {
            delegate?.didReceiveError(error: "error")
//            errorHandler?("Error: \(error.localizedDescription)")
        }
    }
}






//func fetchBooks() async {
//    do {
//        let keyToFetch = "bookResults"
//        if let storedInformation =  UserDefaults.standard.object(forKey: keyToFetch),
//           let StoredBooksModel = try? JSONDecoder().decode(BooksModel.self, from: storedInformation as! Data)
//        {
//            responseHandler?(StoredBooksModel)
//            
//        }else{
//            let booksModel = try await networkCall.BooksFetch(url: URL(string: "https://api.nytimes.com/svc/books/v3/lists/current/hardcover-fiction.json?api-key=WKHndJGECQsOKf2XYga2eyWRsDCygmdN")!)
//            if let encodedInformation = try? JSONEncoder().encode(booksModel){
//                UserDefaults.standard.set(encodedInformation, forKey: keyToFetch)
//                
//                responseHandler?(booksModel)
//            }
//            
//            
//        }
//    } catch let error {
//        errorHandler?(error.localizedDescription)
//    }
//}
