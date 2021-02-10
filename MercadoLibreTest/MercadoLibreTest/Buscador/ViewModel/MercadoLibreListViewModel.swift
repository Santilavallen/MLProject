//
//  MercadoLibreListViewModel.swift
//  MercadoLibreTest
//
//  Created by c08712 on 07/02/2021.
//

import Foundation


protocol MercadoLibreListViewModelProtocol {
    var itemList: [SearchItemModel] { get }
    func retrieveItemList(completion: @escaping (Result<Void, MLError>) -> Void)
}

class MercadoLibreListViewModel: MercadoLibreListViewModelProtocol {
    
    private var itemSearch: String
    private var service: MercadoLibreSearchServiceProtocol
    
    var itemList: [SearchItemModel] = []
    
    init(itemSearch: String) {
        self.itemSearch = itemSearch
        service = MercadoLibreSearchService()
    }
    
    init(itemSearch: String, service: MercadoLibreSearchServiceProtocol) {
        self.itemSearch = itemSearch
        self.service = service
    }
    
    func retrieveItemList(completion: @escaping (Result<Void, MLError>) -> Void) {
        service.retrieveItem(searchItem: itemSearch) { [weak self] (complete) in
            guard let self = self else { return }
            
            switch complete {
            case .success(let itemList):
                if itemList.count > 0 {
                    self.itemList = itemList
                    completion(.success(()))
                } else {
                    completion(.failure(MLError(errorDescription: NSLocalizedString("ml_item_list_empty_error", comment: ""))))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
