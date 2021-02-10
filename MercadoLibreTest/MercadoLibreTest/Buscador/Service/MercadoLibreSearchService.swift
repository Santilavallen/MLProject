//
//  MercadoLibreSearchService.swift
//  MercadoLibreTest
//
//  Created by c08712 on 05/02/2021.
//

import Foundation
import SwiftyJSON

protocol MercadoLibreSearchServiceProtocol {
    func retrieveItem(searchItem: String, completion: @escaping (Result<[SearchItemModel], MLError>) -> Void)
}

class MercadoLibreSearchService: BaseService, MercadoLibreSearchServiceProtocol {
    private var itemResultArray: [SearchItemModel]?
    
    func retrieveItem(searchItem: String, completion: @escaping (Result<[SearchItemModel], MLError>) -> Void) {
        self.request(apiPath: "/sites/MLA/search", parameters: ["q" : searchItem]) { (complete) in
            
            switch complete {
            case .success(let json):
                self.itemResultArray = []
                for item in json["results"].arrayValue {
                    self.itemResultArray?.append(SearchItemModel(json: item))
                }
                completion(.success(self.itemResultArray ?? []))
                
            case .failure(let error):
                print(error)
                completion(.failure(MLError(errorDescription: NSLocalizedString("ml_error_message", comment: ""))))
            }
        }
    }
}
