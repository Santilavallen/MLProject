//
//  MercadoLibreItemDetailViewModelTest.swift
//  MercadoLibreTestTests
//
//  Created by c08712 on 10/02/2021.
//

import XCTest
@testable import MercadoLibreTest

class MercadoLibreItemDetailViewModelTest: XCTestCase {

    var mlListViewModel: MercadoLibreItemDetailViewModelProtocol!
    let sellerCity = "Buenos Aires"
    let sellerState = "Vicente Lopez"
    let sellerName = "Test"
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        mlListViewModel = nil
    }
    
    func test_reputation_type_noReputation() {
        mlListViewModel = MercadoLibreItemDetailViewModel(itemSelected: SearchItemModel(reputation: 0, sellerCity: sellerCity, sellerState: sellerState, condition: .new, sellerName: sellerName))
        
        XCTAssertEqual(mlListViewModel.reputationType(), .noReputation)
    }
    
    func test_reputation_type_redReputation() {
        mlListViewModel = MercadoLibreItemDetailViewModel(itemSelected: SearchItemModel(reputation: 0.10, sellerCity: sellerCity, sellerState: sellerState, condition: .new, sellerName: sellerName))
        
        XCTAssertEqual(mlListViewModel.reputationType(), .reputationRed)
    }
    
    func test_reputation_type_orangeReputation() {
        mlListViewModel = MercadoLibreItemDetailViewModel(itemSelected: SearchItemModel(reputation: 0.30, sellerCity: sellerCity, sellerState: sellerState, condition: .new, sellerName: sellerName))
        
        XCTAssertEqual(mlListViewModel.reputationType(), .reputationOrange)
    }
    
    func test_reputation_type_yellowReputation() {
        mlListViewModel = MercadoLibreItemDetailViewModel(itemSelected: SearchItemModel(reputation: 0.50, sellerCity: sellerCity, sellerState: sellerState, condition: .new, sellerName: sellerName))
        
        XCTAssertEqual(mlListViewModel.reputationType(), .reputationYellow)
    }
    
    func test_reputation_type_lightGreenReputation() {
        mlListViewModel = MercadoLibreItemDetailViewModel(itemSelected: SearchItemModel(reputation: 0.70, sellerCity: sellerCity, sellerState: sellerState, condition: .new, sellerName: sellerName))
        
        XCTAssertEqual(mlListViewModel.reputationType(), .reputationLightGreen)
    }
    
    func test_reputation_type_greenReputation() {
        mlListViewModel = MercadoLibreItemDetailViewModel(itemSelected: SearchItemModel(reputation: 0.90, sellerCity: sellerCity, sellerState: sellerState, condition: .new, sellerName: sellerName))
        
        XCTAssertEqual(mlListViewModel.reputationType(), .reputationGreen)
    }
    
    func test_retrieve_selle_info_succes() {
        mlListViewModel = MercadoLibreItemDetailViewModel(itemSelected: SearchItemModel(reputation: 0.90, sellerCity: sellerCity, sellerState: sellerState, condition: .new, sellerName: sellerName), service: MercadoLibreSellerInfoServiceMock(retrieveError: false))
        
        mlListViewModel.retrieveSellerInfo {
            XCTAssertEqual(self.mlListViewModel.getSellerName(), NSLocalizedString("ml_seller_info_service_mock_response", comment: ""))
        }
    }
    
    func test_retrieve_selle_info_fail() {
        mlListViewModel = MercadoLibreItemDetailViewModel(itemSelected: SearchItemModel(reputation: 0.90, sellerCity: sellerCity, sellerState: sellerState, condition: .new, sellerName: sellerName), service: MercadoLibreSellerInfoServiceMock(retrieveError: true))
        
        mlListViewModel.retrieveSellerInfo {
            XCTAssertEqual(self.mlListViewModel.getSellerName(), self.sellerName)
        }
    }
    
    func test_header_text_for_new() {
        mlListViewModel = MercadoLibreItemDetailViewModel(itemSelected: SearchItemModel(reputation: 0, sellerCity: sellerCity, sellerState: sellerState, condition: .new, sellerName: sellerName))
        
        XCTAssertEqual(mlListViewModel.getHeaderText(), NSLocalizedString("ml_item_detail_new_header", comment: "") + sellerCity + ", " + sellerState)
    }
    
    func test_header_text_for_used() {
        mlListViewModel = MercadoLibreItemDetailViewModel(itemSelected: SearchItemModel(reputation: 0, sellerCity: sellerCity, sellerState: sellerState, condition: .used, sellerName: sellerName))
        
        XCTAssertEqual(mlListViewModel.getHeaderText(), NSLocalizedString("ml_item_detail_used_header", comment: "") + sellerCity + ", " + sellerState)
    }
}
