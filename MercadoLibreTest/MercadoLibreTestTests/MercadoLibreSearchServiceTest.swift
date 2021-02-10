//
//  MercadoLibreSearchServiceTest.swift
//  MercadoLibreTestTests
//
//  Created by c08712 on 10/02/2021.
//

import XCTest
@testable import MercadoLibreTest

class MercadoLibreSearchServiceTest: XCTestCase {

    var mockService: MercadoLibreSearchServiceProtocol!
    let item = NSLocalizedString("ml_succes_item_search", comment: "")
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        mockService = nil
    }
    
    func test_search_service_success() {
        
        mockService = MercadoLibreSearchServiceMock(retrieveError: false, retrieveEmptyResponse: false)
        
        mockService.retrieveItem(searchItem: item) { (completion) in
            
            switch completion {
            case .success(let model):
                XCTAssertEqual(model.count, 1)
            
            case .failure(let error):
                //Validation must succeed
                XCTFail()
            }
        }
    }
    
    func test_search_service_fail() {
        
        mockService = MercadoLibreSearchServiceMock(retrieveError: true, retrieveEmptyResponse: false)
        
        mockService.retrieveItem(searchItem: item) { (completion) in
            
            switch completion {
            case .success(let model):
                //Validation must fail
                XCTFail()
            
            case .failure(let error):
                XCTAssertEqual(error.getErrorDescription(), NSLocalizedString("ml_error_message", comment: ""))
            }
        }
    }

    func test_search_service_success_empty() {
        
        mockService = MercadoLibreSearchServiceMock(retrieveError: false, retrieveEmptyResponse: true)
        
        mockService.retrieveItem(searchItem: item) { (completion) in
            
            switch completion {
            case .success(let model):
                XCTAssertEqual(model.count, 0)
            
            case .failure(let error):
                XCTAssertEqual(error.getErrorDescription(), NSLocalizedString("ml_error_message", comment: ""))
            }
        }
    }
}
