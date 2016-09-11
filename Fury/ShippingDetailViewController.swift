//
//  ShippingDetailViewController.swift
//  Fury
//
//  Created by Nguyen Khang on 9/3/16.
//  Copyright © 2016 kstorevn. All rights reserved.
//

import UIKit

class ShippingDetailViewController: UIViewController {

    var currentItem: Purchase?
    
    @IBOutlet weak var lblNguoiDat: UILabel!
    @IBOutlet weak var lblNgayDat: UILabel!
    @IBOutlet weak var lblTongCong: UILabel!
    
    
    @IBOutlet weak var ngayguiTextField: UITextField!
    @IBOutlet weak var cuocTextField: UITextField!
    @IBOutlet weak var sohieuTextField: UITextField!
    
    @IBAction func save(sender: UIButton) {
        
    }
    
    func data_request()
    {
        let url:NSURL = NSURL(string: String(format: "%@%@", Constants.baseUrl, "Shippings"))!
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        let request = NSMutableURLRequest(URL: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "POST"
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        
        let data:String = String(format: "{\"shippingid\":\"%@\" , \"purchaseid\":\"%@\" , \"so_hieu\": \"%@\",\"cuoc\": %@, \"ngay_gui\": \"%@\"}", NSUUID().UUIDString, (self.currentItem?.PurchaseId)!, self.sohieuTextField.text!, self.cuocTextField.text!, dateFormatter.stringFromDate(NSDate()))
        
        
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
                if ((receivedTodo["shippingid"] as? String) != nil){
                    self.navigationController?.popViewControllerAnimated(true)
                    
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

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
