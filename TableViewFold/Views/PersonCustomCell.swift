//
//  PersonCustomCell.swift
//  TableViewFold
//
//  Created by 陈舒澳 on 16/5/19.
//  Copyright © 2016年 speeda. All rights reserved.
//

import UIKit

class PersonCustomCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var sayingLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
