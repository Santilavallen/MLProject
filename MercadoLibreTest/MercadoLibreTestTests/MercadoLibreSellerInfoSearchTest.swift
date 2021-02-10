//
//  MercadoLibreSellerInfoSearchTest.swift
//  MercadoLibreTestTests
//
//  Created by c08712 on 10/02/2021.
//

import XCTest
@testable import MercadoLibreTest

class MercadoLibreSellerInfoSearchTest: XCTestCase {

    var mockService: MercadoLibreSellerInfoServiceProtocol!
    let sellerID = "123456789"
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        mockService = nil
    }
    
    func test_seller_service_succes() {
        
        mockService = MercadoLibreSellerInfoServiceMock(retrieveError: false)
        
        mockService.retrieveSellerInfo(sellerID: sellerID) { (completion) in
            switch completion {
            case .success(let name):
                XCTAssertEqual(name, NSLocalizedString("ml_seller_info_service_mock_response", comment: ""))
                
            case .failure(let error):
                //Search must succeed
                XCTAssertEqual(error.getErrorDescription(), NSLocalizedString("ml_seller_info_service_mock_fail_error", comment: ""))
            }
        }
    }
    
    func test_seller_service_fail() {
        mockService = MercadoLibreSellerInfoServiceMock(retrieveError: true)
        
        mockService.retrieveSellerInfo(sellerID: sellerID) { (completion) in
            switch completion {
            case .success(let name):
                //Search must fail
                XCTFail()
                
            case .failure(let error):
                //Search must fail
                XCTAssertTrue(true)
            }
        }
    }
    
}
