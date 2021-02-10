//
//  ItemSelectedAttributeTableViewCell.swift
//  MercadoLibreTest
//
//  Created by c08712 on 07/02/2021.
//

import UIKit

class ItemSelectedAttributeTableViewCell: UITableViewCell {

    @IBOutlet weak var attributeTitleView: UIView!
    @IBOutlet weak var attributeTitleLabel: UILabel!
    
    @IBOutlet weak var attributeDescriptionView: UIView!
    @IBOutlet weak var attributeDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func loadCellData(attribute: ItemAttributeModel, rowNumber: Int) {
        attributeTitleLabel.text = attribute.attributeTitle
        attributeDescriptionLabel.text = attribute.attributeDescription
        
        if rowNumber % 2 == 0 {
            attributeTitleView.backgroundColor = UIColor(named: "TableDarkGrey")
            attributeDescriptionView.backgroundColor = UIColor(named: "TableLightGrey")
        } else {
            attributeTitleView.backgroundColor = UIColor(named: "TableLightGrey")
            attributeDescriptionView.backgroundColor = UIColor.white
        }
    }
}
