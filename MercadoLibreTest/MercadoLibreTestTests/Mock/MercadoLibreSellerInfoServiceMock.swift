//
//  MercadoLibreSellerInfoServiceMock.swift
//  MercadoLibreTestTests
//
//  Created by c08712 on 10/02/2021.
//

import Foundation
@testable import MercadoLibreTest

class MercadoLibreSellerInfoServiceMock: MercadoLibreSellerInfoServiceProtocol {
    
    var retrieveError: Bool
    
    var mockResponse = NSLocalizedString("ml_seller_info_service_mock_response", comment: "")
    
    init(retrieveError: Bool) {
        self.retrieveError = retrieveError
    }
    
    func retrieveSellerInfo(sellerID: String, completion: @escaping (Result<String, MLError>) -> Void) {
        
        if retrieveError {
            completion(.failure(MLError(errorDescription: NSLocalizedString("ml_seller_info_service_mock_fail_error", comment: ""))))
        } else {
            completion(.success(mockResponse))
        }
    }
    
}
