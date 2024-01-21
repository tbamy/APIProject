//
//  DIContainer.swift
//  APIProject
//
//  Created by TBAM on 21/01/2024.
//

import Foundation

class DIContainer{
    static let shared: DIContainer = DIContainer()
    
    private init() {}
    
    func makeBookViewModel() -> BooksViewModel{
        BooksViewModel(networkCall: NetworkCall())
    }
    
    func makepopularViewModel() -> PopularViewModel{
        PopularViewModel(networkCall: NetworkCall())
    }
}
