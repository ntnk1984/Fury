//
//  CashTableViewCell.swift
//  Fury
//
//  Created by Nguyen Khang on 9/7/16.
//  Copyright © 2016 kstorevn. All rights reserved.
//

import UIKit

class CashTableViewCell: UITableViewCell {

    @IBOutlet weak var lblSoHieu: UILabel!
    
    @IBOutlet weak var lblNgayGui: UILabel!
    
    @IBOutlet weak var lblTriGia: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
