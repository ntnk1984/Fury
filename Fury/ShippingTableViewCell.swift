//
//  ShippingTableViewCell.swift
//  Fury
//
//  Created by Nguyen Khang on 9/3/16.
//  Copyright © 2016 kstorevn. All rights reserved.
//

import UIKit

class ShippingTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblNguoiDat: UILabel!
    @IBOutlet weak var lblNgayDat: UILabel!
    @IBOutlet weak var lblTongCong: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
