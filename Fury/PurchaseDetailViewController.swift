//
//  PurchaseDetailViewController.swift
//  Fury
//
//  Created by Nguyen Khang on 9/4/16.
//  Copyright © 2016 kstorevn. All rights reserved.
//

import UIKit

class PurchaseDetailViewController: UIViewController {

    var currentItem: Orders?
    @IBOutlet weak var lblTongCong: UILabel!
    @IBOutlet weak var lblNguoiDat: UILabel!
    @IBOutlet weak var lblNgayDat: UILabel!
    @IBOutlet weak var tongcongTextField: UITextField!
    
    @IBOutlet weak var ngaymuaTextField: UITextField!
    
    @IBOutlet weak var giamuaTextField: UITextField!
    
    @IBOutlet weak var phishipTextField: UITextField!
    @IBOutlet weak var phinganhangTextField: UITextField!
    
    
    @IBAction func save(sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
