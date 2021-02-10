//
//  MLExtensions.swift
//  MercadoLibreTest
//
//  Created by c08712 on 05/02/2021.
//

import Foundation

extension Double {
    func currencyFormatt(currency: String) -> String {
        var currencySymbol = ""
        
        switch currency {
        case "ARS":
            currencySymbol = "$"
        case "USD":
            currencySymbol = "U$D"
        default:
            currencySymbol = ""
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.currencySymbol = currencySymbol
        numberFormatter.numberStyle = NumberFormatter.Style.currency
        guard let formatoFinal = numberFormatter.string(from: NSNumber(value: self)) else { return "" }
        
        return formatoFinal.description
        
    }
}
