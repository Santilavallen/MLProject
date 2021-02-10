//
//  ListItemTableViewCell.swift
//  MercadoLibreTest
//
//  Created by c08712 on 05/02/2021.
//

import UIKit
import AlamofireImage
import Alamofire

class ListItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ammountLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var deliveryView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func loadItemData(item: SearchItemModel) {
        titleLabel.text = item.itemTitle
        ammountLabel.text = item.itemPrice.currencyFormatt(currency: item.currencyId)
        cityLabel.text = item.sellerCity + ", " + item.sellerState
        deliveryView.isHidden = !item.freeShipping
        
        guard let url = URL(string: item.itemImage) else { return }
        itemImageView.af.setImage(withURL: url)
    }
    
}
