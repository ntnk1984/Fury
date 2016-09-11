//
//  ShippingViewController.swift
//  Fury
//
//  Created by Nguyen Khang on 9/3/16.
//  Copyright © 2016 kstorevn. All rights reserved.
//

import UIKit

class ShippingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    var purchaseList = [Purchase]()
    
    @IBOutlet weak var tableView: UITableView!
    
        override func viewDidLoad() {
        super.viewDidLoad()

        getPurchaseForShipping()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getPurchaseForShipping(){
        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: String(format: "%@%@", Constants.baseUrl, "getPurchaseForShipping"))!, completionHandler: { (data, response, error) -> Void in
            // Check if data was received successfully
            if error == nil && data != nil {
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! [AnyObject]
                    
                    for dic:AnyObject in json {
                        let ord = Purchase()
                        ord.ngay_mua = (dic as! NSDictionary)["ngay_mua"] as? String
                        ord.gia_mua = (dic as! NSDictionary)["gia_mua"] as? Float
                        ord.phi_ship = (dic as! NSDictionary)["phi_ship"] as? Float
                        ord.phi_ngan_hang = (dic as! NSDictionary)["phi_ngan_hang"] as? Float
                        ord.tong_cong = (dic as! NSDictionary)["tong_cong"] as? Float
                        
                        self.purchaseList.append(ord)
                    }
                    
                    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                    dispatch_async(dispatch_get_global_queue(priority, 0)) {
                        
                        dispatch_async(dispatch_get_main_queue()) {
                            self.tableView.reloadData()
                        }
                    }
                    
                    
                    
                } catch {
                    // Something went wrong
                }
            }
        }).resume()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return purchaseList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell_id", forIndexPath: indexPath) as! PurchaseTableViewCell
        
        let ord = purchaseList[indexPath.row]
        
        cell.lblNgayMua.text = ord.ngay_mua
        cell.lblGiaMua.text = NSNumberFormatter.localizedStringFromNumber(ord.gia_mua!, numberStyle: NSNumberFormatterStyle.DecimalStyle)
        cell.lblPhiShip.text = NSNumberFormatter.localizedStringFromNumber(ord.phi_ship!, numberStyle: NSNumberFormatterStyle.DecimalStyle)
        cell.lblPhiNganHang.text = NSNumberFormatter.localizedStringFromNumber(ord.phi_ngan_hang!, numberStyle: NSNumberFormatterStyle.DecimalStyle)
        cell.lblTongCong.text = NSNumberFormatter.localizedStringFromNumber(ord.tong_cong!, numberStyle: NSNumberFormatterStyle.DecimalStyle)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailView = self.storyboard!.instantiateViewControllerWithIdentifier("ShippingDetailViewController") as! ShippingDetailViewController
        
        //Pass data
        let currentItem = self.purchaseList[indexPath.row]
        
        detailView.currentItem = currentItem;
        //push view
        self.navigationController!.pushViewController(detailView, animated: true)
        
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
