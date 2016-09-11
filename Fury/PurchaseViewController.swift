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
    var selectedList = NSMutableArray()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.definesPresentationContext = true
        getOrderForPurchase()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buy(sender: UIButton) {
        
        
        let detailView = self.storyboard!.instantiateViewControllerWithIdentifier("PurchaseDetailViewController") as! PurchaseDetailViewController
        
        
        self.navigationController!.pushViewController(detailView, animated: true)
        
    }



    func getOrderForPurchase(){
        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: String(format: "%@%@", Constants.baseUrl, "getOrderForPurchase_Result"))!, completionHandler: { (data, response, error) -> Void in
            // Check if data was received successfully
            if error == nil && data != nil {
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! [AnyObject]
                    
                    for dic:AnyObject in json {
                        let ord = Orders()
                        ord.nguoi_dat = (dic as! NSDictionary)["nguoi_dat"] as? String
                        ord.ngay_dat = (dic as! NSDictionary)["ngay_dat"] as? String
                        ord.tong_cong = (dic as! NSDictionary)["tong_cong"] as? Float
                        ord.OrderId = (dic as! NSDictionary)["id"] as? String
                        
                        self.orderList.append(ord)
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
        return orderList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell_id", forIndexPath: indexPath) as! OrderTableViewCell
        
        let ord = orderList[indexPath.row]
        
        if (ord.tong_cong != nil) {
            cell.lblTongCong.text = NSNumberFormatter.localizedStringFromNumber(ord.tong_cong!, numberStyle: NSNumberFormatterStyle.DecimalStyle)
        }
        cell.lblNguoiDat.text = ord.nguoi_dat
        cell.lblNgayDat.text = ord.ngay_dat
        
        
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

