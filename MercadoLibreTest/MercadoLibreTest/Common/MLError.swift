//
//  MLError.swift
//  MercadoLibreTest
//
//  Created by c08712 on 09/02/2021.
//

import Foundation

struct MLError: Error {
    
    private var errorDescription: String
    private var errorCode: String?
    
    init(errorDescription: String) {
        self.errorDescription = errorDescription
    }
    
    func getErrorDescription() -> String {
        return errorDescription
    }
    
    func getErrorCode() -> String {
        return errorCode ?? ""
    }
}
