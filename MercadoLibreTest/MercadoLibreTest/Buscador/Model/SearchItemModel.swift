//
//  SearchItemModel.swift
//  MercadoLibreTest
//
//  Created by c08712 on 05/02/2021.
//

import Foundation
import SwiftyJSON

enum itemCondition {
    case new
    case used
}

struct SearchItemModel {
    
    var itemTitle: String
    var itemPrice: Double
    var currencyId: String
    var itemImage: String
    var availableQuantity: Int
    var condition: itemCondition
    var freeShipping: Bool
    var sellerState: String
    var sellerCity: String
    var sellerInformation: ItemSellerInformationModel
    var reputation: Double
    var attributes: [ItemAttributeModel] = []
    
    init(json: JSON) {
        itemTitle = json["title"].stringValue
        itemPrice = json["price"].doubleValue
        currencyId = json["currency_id"].stringValue
        itemImage = json["thumbnail"].stringValue
        availableQuantity = json["available_quantity"].intValue
        freeShipping = json["shipping"]["free_shipping"].boolValue
        sellerState = json["seller_address"]["state"]["name"].stringValue
        sellerCity = json["seller_address"]["city"]["name"].stringValue
        sellerInformation = ItemSellerInformationModel(json: json["seller"])
        reputation = json["seller"]["seller_reputation"]["transactions"]["ratings"]["positive"].doubleValue
        
        for attribute in json["attributes"].arrayValue {
            attributes.append(ItemAttributeModel(json: attribute))
        }
        
        switch json["condition"].stringValue {
        case "new":
            condition = .new
        default:
            condition = .used
        }
    }
    
    init(reputation: Double, sellerCity: String, sellerState: String, condition: itemCondition, sellerName: String) {
        itemTitle = ""
        itemPrice = 0
        currencyId = ""
        itemImage = ""
        availableQuantity = 0
        freeShipping = true
        self.sellerState = sellerState
        self.sellerCity = sellerCity
        sellerInformation = ItemSellerInformationModel(json: JSON())
        sellerInformation.name = sellerName
        self.reputation = reputation
        attributes = []
        self.condition = condition
    }
    
}
