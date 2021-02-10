//
//  ItemSellerInformationModel.swift
//  MercadoLibreTest
//
//  Created by c08712 on 07/02/2021.
//

import Foundation
import SwiftyJSON

struct ItemSellerInformationModel {

    var name: String
    var logoImage: String
    var totalTransactions: Int
    var sellerID: String
    
    init(json: JSON) {
        name = json["eshop"]["nick_name"].stringValue
        logoImage = json["eshop"]["eshop_logo_url"].stringValue
        totalTransactions = json["seller_reputation"]["transactions"]["completed"].intValue
        sellerID = json["id"].stringValue
    }
    
}
