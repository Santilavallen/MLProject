//
//  MercadoLibreItemDetailViewController.swift
//  MercadoLibreTest
//
//  Created by c08712 on 05/02/2021.
//

import UIKit
import AlamofireImage

class MercadoLibreItemDetailViewController: UIViewController {

    @IBOutlet weak var headerInfoLabel: UILabel!
    @IBOutlet weak var itemTitleLabel: UILabel!
    
    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var deliveryImageView: UIImageView!
    @IBOutlet weak var deliveryLabel: UILabel!
    
    @IBOutlet weak var sellerImageView: UIImageView!
    @IBOutlet weak var sellerNameLabel: UILabel!
    @IBOutlet weak var sellAmountLabel: UILabel!
    
    @IBOutlet weak var reputationRed: UILabel!
    @IBOutlet weak var reputationOrange: UILabel!
    @IBOutlet weak var reputationYellow: UILabel!
    @IBOutlet weak var reputationLightGreen: UILabel!
    @IBOutlet weak var reputationGreen: UILabel!
    
    @IBOutlet weak var itemInformationTableView: UITableView!
    @IBOutlet weak var itemInformaionTableViewHeight: NSLayoutConstraint!
    
    var itemSelected: SearchItemModel?
    private var viewmodel: MercadoLibreItemDetailViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTable()
        retrieveSellerInfo()
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { _ in
            self.itemInformationTableView.reloadData()
        }
    }
    
    func retrieveSellerInfo() {
        guard let itemSelected = itemSelected else { return }
        
        Utils.showLoading()
        viewmodel = MercadoLibreItemDetailViewModel(itemSelected: itemSelected)
        viewmodel?.retrieveSellerInfo(completion: {
            self.loadViewData()
        })
    }
    
    func loadViewData() {
        guard let itemSelected = itemSelected else {
            Utils.hideLoading()
            return
        }
        
        headerInfoLabel.text = viewmodel?.getHeaderText()
        itemTitleLabel.text = itemSelected.itemTitle
        priceLabel.text = itemSelected.itemPrice.currencyFormatt(currency: itemSelected.currencyId)
        
        deliveryImageView.isHidden = !(itemSelected.freeShipping)
        deliveryLabel.isHidden = !(itemSelected.freeShipping)
        
        sellerNameLabel.text = viewmodel?.getSellerName()
        sellAmountLabel.text = (itemSelected.sellerInformation.totalTransactions.description) + " ventas"
        
        configureReputation()
        
        if (itemSelected.sellerInformation.logoImage.isEmpty) {
            sellerImageView.isHidden = true
        } else {
            guard let logoUrl = URL(string: itemSelected.sellerInformation.logoImage) else {
                Utils.hideLoading()
                return
            }
            sellerImageView.af.setImage(withURL: logoUrl)
        }
        
        guard let url = URL(string: itemSelected.itemImage) else {
            Utils.hideLoading()
            return
        }
        itemImageView.af.setImage(withURL: url)
        
        Utils.hideLoading()
    }
    
    func configureReputation() {
        switch (viewmodel?.reputationType()) {
        case .reputationRed:
            reputationRed.backgroundColor = UIColor.init(named: "Rep_Red")
        case .reputationOrange:
            reputationOrange.backgroundColor = UIColor.init(named: "Rep_Orange")
        case .reputationYellow:
            reputationYellow.backgroundColor = UIColor.init(named: "Rep_Yellow")
        case .reputationLightGreen:
            reputationLightGreen.backgroundColor = UIColor.init(named: "Rep_Green")
        case .reputationGreen:
            reputationGreen.backgroundColor = UIColor.init(named: "Delivery_color")
        default:
            reputationRed.backgroundColor = UIColor.lightGray
            reputationOrange.backgroundColor = UIColor.lightGray
            reputationYellow.backgroundColor = UIColor.lightGray
            reputationLightGreen.backgroundColor = UIColor.lightGray
            reputationGreen.backgroundColor = UIColor.lightGray
        }
    }
    
    func configureTable() {
        itemInformationTableView.delegate = self
        itemInformationTableView.dataSource = self
    }
    
}

extension MercadoLibreItemDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemSelected?.attributes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemAttributeCell") as? ItemSelectedAttributeTableViewCell,
              let attribute = itemSelected?.attributes[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.loadCellData(attribute: attribute, rowNumber: indexPath.row)
        
        itemInformaionTableViewHeight.constant = tableView.contentSize.height
        tableView.layoutIfNeeded()
        
        return cell
    }
    
    
}
