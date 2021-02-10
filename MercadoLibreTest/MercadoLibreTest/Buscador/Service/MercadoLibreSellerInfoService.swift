//
//  MercadoLibreSellerInfoService.swift
//  MercadoLibreTest
//
//  Created by c08712 on 08/02/2021.
//

import Foundation
import SwiftyJSON

protocol MercadoLibreSellerInfoServiceProtocol {
    func retrieveSellerInfo(sellerID: String, completion: @escaping (Result<String, MLError>) -> Void)
}

class MercadoLibreSellerInfoService: BaseService, MercadoLibreSellerInfoServiceProtocol {
    
    func retrieveSellerInfo(sellerID: String, completion: @escaping (Result<String, MLError>) -> Void) {
        self.request(apiPath: "/sites/MLA/search", parameters: ["seller_id" : sellerID]) { (complete) in
            
            switch complete {
            case .success(let json):
                completion(.success(json["seller"]["nickname"].stringValue))
                
            case .failure(let error):
                print(error)
                completion(.failure(MLError.init(errorDescription: error.localizedDescription)))
            }
        }
    }
}
