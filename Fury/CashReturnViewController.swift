//
//  CashReturnViewController.swift
//  Fury
//
//  Created by Nguyen Khang on 9/3/16.
//  Copyright © 2016 kstorevn. All rights reserved.
//

import UIKit

class CashReturnViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var lblTongTien: UILabel!
    var shippingList = [Shipping]()
    var selectedList = NSMutableArray()
    
    let identifier = "cell_id"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.allowsMultipleSelection = true
        getShippingForCashReturn()
        
        
    }

    @IBAction func goodPickup(sender: UIButton) {
    }
    
    @IBAction func cashPickup(sender: UIButton) {
        for i in 0 ..< self.selectedList.count {
            let sh : Shipping = self.selectedList[i] as! Shipping
            data_request(i, ShippingID: sh.shippingid!, Code: sh.so_hieu!)
        }
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
        }


    }
    
    func data_request(Index: Int ,ShippingID: String, Code: String)
    {
        let url:NSURL = NSURL(string: String(format: "%@%@", Constants.baseUrl, "CashReturns"))!
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        let request = NSMutableURLRequest(URL: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "POST"
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        
        let data:String = String(format: "{\"cashreturnid\":\"%@\" , \"shippingid\":\"%@\" , \"so_hieu\": \"%@\" , \"ngay_thu\": \"%@\"}", NSUUID().UUIDString, ShippingID, Code, dateFormatter.stringFromDate(NSDate()))
        
        request.HTTPBody = data.dataUsingEncoding(NSUTF8StringEncoding);
        
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) in
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            guard error == nil else {
                print("error calling POST on /todos/1")
                print(error)
                return
            }
            
            do {
                guard let receivedTodo = try NSJSONSerialization.JSONObjectWithData(responseData,
                                                                                    options: []) as? [String: AnyObject] else {
                                                                                        print("Could not get JSON from responseData as dictionary")
                                                                                        return
                }
                if ((receivedTodo["cashreturnid"] as? String) != nil){
                   self.selectedList.removeObject(self.selectedList[Index])
                    
                   
                }
                else {
                    print("Could not get todoID as int from JSON")
                    return
                }
                
            } catch  {
                print("error parsing response from POST on /todos")
                return
            }
        }
        
        task.resume()
    }
    
    
    func getShippingForCashReturn(){
        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: String(format: "%@%@", Constants.baseUrl, "getShippingForCashReturn"))!, completionHandler: { (data, response, error) -> Void in
            // Check if data was received successfully
            if error == nil && data != nil {
                do {
                    //var dataString = NSString(data: data!, encoding:NSUTF8StringEncoding)
                    
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! [AnyObject]
                    
                    //self.shippingList = json!
                    // Access specific key with value of type String
                    
                    
                     for dic:AnyObject in json {
                        let ord = Shipping()
                        ord.so_hieu = (dic as! NSDictionary)["so_hieu"] as? String
                        ord.ngay_gui = (dic as! NSDictionary)["ngay_gui"] as? String
                        ord.tri_gia = (dic as! NSDictionary)["tri_gia"] as? Float
                        
                        self.shippingList.append(ord)
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

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shippingList.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell_id") as! CashTableViewCell
        
        
        let currentShipping = shippingList[indexPath.row]
        cell.lblSoHieu.text = currentShipping.so_hieu
        cell.lblNgayGui.text = currentShipping.ngay_gui
        cell.lblTriGia.text = NSNumberFormatter.localizedStringFromNumber(currentShipping.tri_gia!, numberStyle: NSNumberFormatterStyle.DecimalStyle)
        return cell
    }
    
    
    

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell  = tableView.cellForRowAtIndexPath(indexPath)
        cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
        
        //tableView.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: UITableViewScrollPosition.None)
        self.selectedList.addObject(self.shippingList[indexPath.row])
        
        calAmount()
    }

    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell  = tableView.cellForRowAtIndexPath(indexPath)
        cell!.accessoryType = UITableViewCellAccessoryType.None
        
        tableView.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: UITableViewScrollPosition.None)
        
        self.selectedList.removeObject(self.shippingList[indexPath.row])
        
        calAmount()
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func calAmount(){
        var Amount: Float = 0.0
        
       
        for i in 0 ..< self.selectedList.count {
            let sh : Shipping = self.selectedList[i] as! Shipping
            Amount = Amount + sh.tri_gia!
        }
        
        self.lblTongTien.text = NSNumberFormatter.localizedStringFromNumber(Amount, numberStyle: NSNumberFormatterStyle.DecimalStyle)

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
