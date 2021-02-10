//
//  MercadoLibreSearchServiceMock.swift
//  MercadoLibreTestTests
//
//  Created by c08712 on 10/02/2021.
//

import Foundation
import SwiftyJSON
@testable import MercadoLibreTest

class MercadoLibreSearchServiceMock: MercadoLibreSearchServiceProtocol {
    
    var retrieveError: Bool
    var retrieveEmptyResponse: Bool
    var mockItemResponse: [SearchItemModel] = [SearchItemModel(json: JSON())]
    
    init(retrieveError: Bool, retrieveEmptyResponse: Bool) {
        self.retrieveError = retrieveError
        self.retrieveEmptyResponse = retrieveEmptyResponse
    }
    
    func retrieveItem(searchItem: String, completion: @escaping (Result<[SearchItemModel], MLError>) -> Void) {
        if retrieveError {
            completion(.failure(MLError(errorDescription: NSLocalizedString("ml_error_message", comment: ""))))
        } else {
            if retrieveEmptyResponse {
                completion(.success([]))
            } else {
                completion(.success(mockItemResponse))
            }
        }
    }
    
    
}
