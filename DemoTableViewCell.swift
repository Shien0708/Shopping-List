//
//  DemoTableViewCell.swift
//  Shopping List
//
//  Created by Shien on 2022/5/25.
//

import UIKit

class DemoTableViewCell: UITableViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
