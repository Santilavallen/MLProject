//
//  MercadoLibreItemDetailViewModel.swift
//  MercadoLibreTest
//
//  Created by c08712 on 07/02/2021.
//

import Foundation

enum SellerReputation {
    case reputationRed
    case reputationOrange
    case reputationYellow
    case reputationLightGreen
    case reputationGreen
    case noReputation
}

protocol MercadoLibreItemDetailViewModelProtocol {
    func getHeaderText() -> String
    func getSellerName() -> String
    func reputationType() -> SellerReputation
    func retrieveSellerInfo(completion: @escaping () -> ())
}

class MercadoLibreItemDetailViewModel: MercadoLibreItemDetailViewModelProtocol {
    
    var itemSelected: SearchItemModel
    var service: MercadoLibreSellerInfoServiceProtocol?
    
    init(itemSelected: SearchItemModel) {
        self.itemSelected = itemSelected
        service = MercadoLibreSellerInfoService()
    }
    
    init(itemSelected: SearchItemModel, service: MercadoLibreSellerInfoServiceProtocol) {
        self.itemSelected = itemSelected
        self.service = service
    }
    
    func getHeaderText() -> String {
        
        switch itemSelected.condition {
        case .new:
            return (NSLocalizedString("ml_item_detail_new_header", comment: "") + itemSelected.sellerCity + ", " + itemSelected.sellerState)
            
        case .used:
            return (NSLocalizedString("ml_item_detail_used_header", comment: "") + itemSelected.sellerCity + ", " + itemSelected.sellerState)
        }
    }
    
    func retrieveSellerInfo(completion: @escaping () -> ()) {
        service?.retrieveSellerInfo(sellerID: itemSelected.sellerInformation.sellerID, completion: { (complete) in
            switch complete {
            case .success(let sellerNickname):
                self.itemSelected.sellerInformation.name = sellerNickname
                completion()
                
            case .failure(let error):
                completion()
            }
        })
    }
    
    func getSellerName() -> String {
        return itemSelected.sellerInformation.name
    }
    
    func reputationType() -> SellerReputation {
        if itemSelected.reputation > 0.0 && itemSelected.reputation <= 0.20 {
            return .reputationRed
        }
        
        if itemSelected.reputation > 0.20 && itemSelected.reputation <= 0.40 {
            return .reputationOrange
        }
        
        if itemSelected.reputation > 0.40 && itemSelected.reputation <= 0.60 {
            return .reputationYellow
        }
        
        if itemSelected.reputation > 0.60 && itemSelected.reputation <= 0.80 {
            return .reputationLightGreen
        }
        
        if itemSelected.reputation > 0.80 && itemSelected.reputation <= 1.0 {
            return .reputationGreen
        }
        
        return .noReputation
    }
}
