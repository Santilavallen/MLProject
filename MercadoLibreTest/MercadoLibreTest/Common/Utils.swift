//
//  Utils.swift
//  MercadoLibreTest
//
//  Created by c08712 on 08/02/2021.
//

import UIKit
import NVActivityIndicatorView

class Utils {
    
    
    static func showAlert(controller: UINavigationController, title: String?, message: String, alertAction: @escaping () -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "ACEPTAR", style: .default, handler: { action in
            alertAction()
        }))
        
        controller.present(alert, animated: true)
    }
    
    static func showLoading() {
        let activityData = ActivityData(size: CGSize(width: 44, height: 44),
                                        message: "Cargando",
                                        messageFont: UIFont.systemFont(ofSize: 16, weight: .semibold),
                                        messageSpacing: nil,
                                        type: .ballPulse,
                                        color: UIColor.white,
                                        padding: 0,
                                        displayTimeThreshold: 0,
                                        minimumDisplayTime: 5,
                                        backgroundColor: UIColor.black.withAlphaComponent(0.8),
                                        textColor: nil)
        
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, nil)
        
    }
    
    static func hideLoading() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
    }
    
}
