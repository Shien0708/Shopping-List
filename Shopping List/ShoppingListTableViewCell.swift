//
//  ShppingListTableViewCell.swift
//  Shopping List
//
//  Created by Shien on 2022/5/24.
//

import UIKit

class ShoppingListTableViewCell: UITableViewCell {

    @IBOutlet weak var itemUnitLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
