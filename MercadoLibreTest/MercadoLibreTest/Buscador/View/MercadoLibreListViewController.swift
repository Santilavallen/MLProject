//
//  MercadoLibreListViewController.swift
//  MercadoLibreTest
//
//  Created by c08712 on 05/02/2021.
//

import UIKit

class MercadoLibreListViewController: UIViewController {

    @IBOutlet weak var searchTableView: UITableView!
    
    
    var searchItem: String?
    var viewmodel: MercadoLibreListViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        retrieveItemList()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = searchItem
        navigationController?.navigationBar.barTintColor = UIColor(named: "Primary_color")
        navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        title = ""
    }
    
    func configureView() {
        viewmodel = MercadoLibreListViewModel(itemSearch: searchItem ?? "")
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
    }
    
    func retrieveItemList() {
        Utils.showLoading()
        viewmodel?.retrieveItemList(completion: { (completion) in
            switch completion {
            case .success():
                self.searchTableView.reloadData()
                Utils.hideLoading()
            case .failure(let error):
                Utils.hideLoading()
                guard let navigationController = self.navigationController else { return }
                Utils.showAlert(controller: navigationController,
                                title: "",
                                message: error.getErrorDescription()) {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination as? MercadoLibreItemDetailViewController, let item = sender as? SearchItemModel else { return }
        viewController.title = searchItem
        viewController.itemSelected = item
    }
}

extension MercadoLibreListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewmodel = viewmodel else { return 0 }
        
        return viewmodel.itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewmodel = viewmodel, let cell = tableView.dequeueReusableCell(withIdentifier: "itemListCell") as? ListItemTableViewCell else {
            return UITableViewCell()
        }
        
        cell.loadItemData(item: viewmodel.itemList[indexPath.row] )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        performSegue(withIdentifier: "go_to_product_detail", sender: viewmodel?.itemList[indexPath.row])
    }
    
}
