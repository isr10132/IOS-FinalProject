//
//  FoodTableViewCell.swift
//  FinalProject
//
//  Created by User02 on 2018/6/26.
//  Copyright © 2018年 isr10132. All rights reserved.
//

import UIKit

class FoodTableViewCell: UITableViewCell {

    @IBOutlet weak var storeLabel: UILabel!
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
