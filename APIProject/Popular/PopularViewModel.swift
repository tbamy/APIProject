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
    
    @MainActor
    func fetchPopular() async {
        do {
            if let storedRecord = RealmHelper.shared.realm.objects(PopularModel.self).first{
                delegate?.didReceiveResponse(data: storedRecord)
//                responseHandler?(storedRecord)
            }else{
                let popularModel = try await networkCall.PopularFetch(url: URL(string: "https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json?api-key=WKHndJGECQsOKf2XYga2eyWRsDCygmdN")!)
                if let popularRecord = popularModel{
                    try RealmHelper.shared.realm.write({
                        RealmHelper.shared.realm.add(popularRecord)
                        delegate?.didReceiveResponse(data: popularRecord)
//                        self.responseHandler?(popularRecord)
                    })
                }
            }
            
            
        } catch let error {
            delegate?.didReceiveError(error: "error")
//            errorHandler?(error.localizedDescription)
        }
    }
}


//func fetchPopular() async {
//    do {
//        let keyToFetch = "popularResults"
//        if let storedInformation =  UserDefaults.standard.object(forKey: keyToFetch),
//           let StoredPopularModel = try? JSONDecoder().decode(PopularModel.self, from: storedInformation as! Data)
//        {
//            responseHandler?(StoredPopularModel)
//            
//        }else{
//            let popularModel = try await networkCall.PopularFetch(url: URL(string: "https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json?api-key=WKHndJGECQsOKf2XYga2eyWRsDCygmdN")!)
//            if let encodedInformation = try? JSONEncoder().encode(popularModel){
//                UserDefaults.standard.set(encodedInformation, forKey: keyToFetch)
//            }
//            
//            responseHandler?(popularModel)
//        }
//        
//        
//    } catch let error {
//        errorHandler?(error.localizedDescription)
//    }
//}
