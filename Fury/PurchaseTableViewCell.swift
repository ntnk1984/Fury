//
//  PurchaseTableViewCell.swift
//  Fury
//
//  Created by Nguyen Khang on 9/7/16.
//  Copyright © 2016 kstorevn. All rights reserved.
//

import UIKit

class PurchaseTableViewCell: UITableViewCell {

    @IBOutlet weak var lblGiaMua: UILabel!
    
    @IBOutlet weak var lblNgayMua: UILabel!
    
    @IBOutlet weak var lblPhiShip: UILabel!
    
    @IBOutlet weak var lblPhiNganHang: UILabel!
    
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
