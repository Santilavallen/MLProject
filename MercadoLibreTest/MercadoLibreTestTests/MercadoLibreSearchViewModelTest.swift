//
//  MercadoLibreSearchViewModelTest.swift
//  MercadoLibreTestTests
//
//  Created by c08712 on 09/02/2021.
//

import XCTest
@testable import MercadoLibreTest

class MercadoLibreSearchViewModelTest: XCTestCase {

    var searchViewModel: MercadoLibreSearchViewModel!
    
    override func setUp() {
        super.setUp()
        searchViewModel = MercadoLibreSearchViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        searchViewModel = nil
    }
    
    func test_validate_search_empty() {
        let emptyError = NSLocalizedString("ml_error_search_empty_error", comment: "")
        
        searchViewModel.validateSearch(search: "", completion: { (completion) in
            switch completion {
            case .success():
                //Validation must fail
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error.getErrorDescription(), emptyError)
            }
        })
    }
    
    func test_validate_search_not_valid() {
        let notValidError = NSLocalizedString("ml_search_not_valid", comment: "")
        
        searchViewModel.validateSearch(search: "a", completion: { (completion) in
            switch completion {
            case .success():
                //Validation must fail
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error.getErrorDescription(), notValidError)
            }
        })
        
        searchViewModel.validateSearch(search: "  ", completion: { (completion) in
            switch completion {
            case .success():
                //Validation must fail
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error.getErrorDescription(), notValidError)
            }
        })
    }
    
    func test_validate_serach_succes() {
        searchViewModel.validateSearch(search: NSLocalizedString("ml_succes_item_search", comment: ""), completion: { (completion) in
            switch completion {
            case .success():
                XCTAssertTrue(true)
            case .failure(let error):
                //Validation must succeed
                XCTFail()
                
            }
        })
    }
}
