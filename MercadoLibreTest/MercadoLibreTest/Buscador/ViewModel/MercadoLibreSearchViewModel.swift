//
//  MercadoLibreSearchViewModel.swift
//  MercadoLibreTest
//
//  Created by c08712 on 09/02/2021.
//

import Foundation

protocol MercadoLibreSearchViewModelProtocol {
    func validateSearch(search: String, completion: @escaping (Result<Void, MLError>) -> Void)
}

class MercadoLibreSearchViewModel: MercadoLibreSearchViewModelProtocol {
    
    func validateSearch(search: String, completion: @escaping (Result<Void, MLError>) -> Void) {
        
        if search.count == 0 {
            return completion(.failure(MLError(errorDescription: NSLocalizedString("ml_error_search_empty_error", comment: ""))))
        }
        
        if search.trimmingCharacters(in: .whitespacesAndNewlines).count < 2 || search.count < 2 {
            return completion(.failure(MLError(errorDescription: NSLocalizedString("ml_search_not_valid", comment: ""))))
        }
        
        completion(.success(()))
    }
    
}
