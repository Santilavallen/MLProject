//
//  BaseService.swift
//  MercadoLibreTest
//
//  Created by c08712 on 05/02/2021.
//

import Alamofire
import SwiftyJSON


protocol BaseServiceProtocol {
    func request(apiPath: String, parameters: [String: String]?, completion: @escaping (Result<JSON, Error>) -> Void)
}

class BaseService: BaseServiceProtocol {
    
    private var baseURL = "https://api.mercadolibre.com"
    private var sessionManager: Session?
    
    func request(apiPath: String, parameters: [String: String]?, completion: @escaping (Result<JSON, Error>) -> Void) {
        sessionConfiguration()
        
        let urlString = baseURL + apiPath
        
        sessionManager?.request(urlString,
                                method: HTTPMethod(rawValue: "POST"),
                                parameters: parameters,
                                encoding: URLEncoding.default,
                                headers: nil
        ).validate().responseData { (response) in
            
            switch response.result {
            case .success(let data):
                
                do {
                    let json = try JSON(data: data)
                    completion(.success(json))
                } catch (let error) {
                    print(error)
                    completion(.failure(error))
                }
                
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
            
        }
    }
    
    func sessionConfiguration() {
        let manager = ServerTrustManager(allHostsMustBeEvaluated: false, evaluators: [URL(string: baseURL)?.host ?? "": DisabledTrustEvaluator()])
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = TimeInterval(40)
        configuration.timeoutIntervalForResource = TimeInterval(40)
        
        sessionManager = Session(configuration: configuration, serverTrustManager: manager)
    }
}
