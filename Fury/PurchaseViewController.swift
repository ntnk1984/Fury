//
//  SecondViewController.swift
//  Fury
//
//  Created by Nguyen Khang on 8/31/16.
//  Copyright © 2016 kstorevn. All rights reserved.
//

import UIKit

class PurchaseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var orderList = [Orders]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getOrderForPurchase()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getOrderForPurchase(){
        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: String(format: "%@%@", Constants.baseUrl, "Orders"))!, completionHandler: { (data, response, error) -> Void in
            // Check if data was received successfully
            if error == nil && data != nil {
                do {
                    //var dataString = NSString(data: data!, encoding:NSUTF8StringEncoding)
                    
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? [Orders]
                    
                    self.orderList = json!
                    // Access specific key with value of type String
                    
                    /*
                    for ord:Orders in json! {
                        //let ord = Orders()
                        ord.nguoi_dat = ord//json["nguoi_dat"] as? String
                        ord.ngay_dat = json["ngay_dat"] as? String
                        ord.tong_cong = json["tong_cong"] as? String
                    }
                    */
                    
                    
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
        return orderList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell_id", forIndexPath: indexPath) as! OrderTableViewCell
        
        let ord = orderList[indexPath.row]
        
        cell.lblNguoiDat.text = ord.nguoi_dat
        cell.lblNgayDat.text = ord.ngay_dat
        cell.lblTongCong.text = ord.tong_cong
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailView = self.storyboard!.instantiateViewControllerWithIdentifier("PurchaseDetailViewController") as! PurchaseDetailViewController
        
        //Pass data
        let currentItem = self.orderList[indexPath.row]
        
        detailView.currentItem = currentItem;
        //push view
        self.navigationController!.pushViewController(detailView, animated: true)
        
    }

}

