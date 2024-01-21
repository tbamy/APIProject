//
//  PopularViewModel.swift
//  APIProject
//
//  Created by TBAM on 21/01/2024.
//

import Foundation

protocol PopularViewModelDelegate: AnyObject {
    func didReceiveResponse(data: PopularModel?)
    func didReceiveError(error: String)
}

class PopularViewModel {
    
    var networkCall: NetworkCall
    
    init(networkCall: NetworkCall) {
        self.networkCall = networkCall
    }
    
    weak var delegate: PopularViewModelDelegate?
    
    var responseHandler: ((PopularModel?) -> Void)?
    var errorHandler: ((String?) -> Void)?
    
    func fetchPopular() async {
        do {
            let popularModel = try await networkCall.PopularFetch(url: URL(string: "https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json?api-key=WKHndJGECQsOKf2XYga2eyWRsDCygmdN")!)
            responseHandler?(popularModel)
        } catch let error {
            errorHandler?(error.localizedDescription)
        }
    }
}
