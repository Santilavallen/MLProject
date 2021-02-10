//
//  ItemAttributeModel.swift
//  MercadoLibreTest
//
//  Created by c08712 on 05/02/2021.
//

import Foundation
import SwiftyJSON

struct ItemAttributeModel {
    
    var attributeTitle: String
    var attributeDescription: String
    
    init(json: JSON) {
        attributeTitle = json["name"].stringValue
        attributeDescription = json["value_name"].stringValue
    }
}

