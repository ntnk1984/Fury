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
    
    @IBOutlet weak var tongcongTextField: UITextField!
    
    @IBOutlet weak var ngaymuaTextField: UITextField!
    
    @IBOutlet weak var giamuaTextField: UITextField!
    
    @IBOutlet weak var phishipTextField: UITextField!
    @IBOutlet weak var phinganhangTextField: UITextField!
    
    var datePicker: UIDatePicker!
    
    @IBOutlet weak var lblNguoiDat: UILabel!
    
    @IBOutlet weak var lblNgayDat: UILabel!
    
    @IBOutlet weak var lblTongCong: UILabel!
    
    
    
    @IBAction func save(sender: UIButton) {
        data_request()
        
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func ngaymuaEditBegin(sender: UITextField) {
        let inputView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 240))
        
        
        datePicker = UIDatePicker(frame: CGRectMake(0, 40, 0, 0))
        datePicker.datePickerMode = UIDatePickerMode.Date
        inputView.addSubview(datePicker) // add date picker to UIView
        
        let doneButton = UIButton(frame: CGRectMake((self.view.frame.size.width/2) - (100/2), 0, 100, 50))
        doneButton.setTitle("Chọn", forState: UIControlState.Normal)
        doneButton.setTitle("Chọn", forState: UIControlState.Highlighted)
        doneButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        doneButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        
        inputView.addSubview(doneButton) // add Button to UIView
        
        doneButton.addTarget(self, action: "doneButton:", forControlEvents: UIControlEvents.TouchUpInside) // set button click event
        
        sender.inputView = inputView
        datePicker.addTarget(self, action: Selector("handleDatePicker:"), forControlEvents: UIControlEvents.ValueChanged)
        
        handleDatePicker(datePicker) // Set the date on start.
        
    }
    
    
    func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        ngaymuaTextField.text = dateFormatter.stringFromDate(sender.date)
    }
    
    func doneButton(sender:UIButton)
    {
        datePicker.resignFirstResponder()
        ngaymuaTextField.resignFirstResponder()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        self.lblNguoiDat.text = self.currentItem?.nguoi_dat
        self.lblNgayDat?.text = self.currentItem?.ngay_dat
        self.lblTongCong?.text = NSNumberFormatter.localizedStringFromNumber((self.currentItem?.tong_cong)!, numberStyle: NSNumberFormatterStyle.DecimalStyle)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func data_request()
    {
        let url:NSURL = NSURL(string: String(format: "%@%@", Constants.baseUrl, "Purchases"))!
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        let request = NSMutableURLRequest(URL: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "POST"
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        print(self.currentItem?.OrderId!)
        
        let data:String = String(format:
            "{\"purchaseId\":\"%@\", \"orderId\":\"%@\", \"ma_sp\":\"\", \"so_luong\":0 , \"gia_mua\": %@ , \"phi_ship\": %@, \"phi_ngan_hang\": %@, \"tong_cong\": %@, \"nha_cung_cap\":\"\", \"ngay_mua\": \"%@\", \"trang_thai\":\"0\"}"
            
            
            , NSUUID().UUIDString
            , (self.currentItem?.OrderId!)!
            , self.giamuaTextField.text!
            , self.phishipTextField.text!
            , self.phinganhangTextField.text!
            , self.tongcongTextField.text!
            , self.ngaymuaTextField.text!
            //, dateFormatter.stringFromDate(NSDate())
        )
        
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
                
                if ((receivedTodo["purchaseId"] as? String) != nil){
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
    
    func update_order()
    {
        let url:NSURL = NSURL(string: String(format: "%@%@", Constants.baseUrl, "Orders"))!
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        print(url)
        let session = NSURLSession(configuration: config)
        
        let request = NSMutableURLRequest(URL: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "PUT"
        //request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        /*
         let paramString = [
         
         "id": NSUUID().UUIDString,
         "ngay_dat": ngaydatTextField.text!,
         "ma_sp": "",
         "so_luong": soluongTextField.text!,
         "mau_sac": "",
         "gia_ban_le": giabanleTextField.text!,
         "tien_ship": tienshipTextField.text!,
         "tong_cong": tongcongTextField.text!,
         "nguoi_dat": nguoidatTextField.text!,
         "dien_thoai": dienthoaiTextField.text!,
         "trang_thai": "0",
         "dia_chi": diachiTextField.text!,
         "cong_doan": "1"
         
         
         ] as  Dictionary<String,String>
         */
        
        let data:String = String(format: "{\"id\":\"%@\" , \"ngay_dat\":\"%@\" , \"ma_sp\":\"\" , \"so_luong\": %@, \"mau_sac\":\"\", \"gia_ban_le\":%@, \"tien_ship\": %@, \"tong_cong\":%@, \"nguoi_dat\":\"%@\", \"dien_thoai\":\"%@\", \"trang_thai\":\"0\", \"dia_chi\":\"%@\", \"cong_doan\":\"1\"}", self.currentItem?.OrderId, self.currentItem?.ngay_dat, self.currentItem?.so_luong, self.currentItem?.gia_ban_le, self.currentItem?.tien_ship, self.currentItem?.tong_cong, self.currentItem?.nguoi_dat, self.currentItem?.dien_thoai, self.currentItem.dia_chi)
        
        
        request.HTTPBody = data.dataUsingEncoding(NSUTF8StringEncoding);
        
        print(data)
        
        /*
         let jsonTodo: NSData
         do {
         jsonTodo = try NSJSONSerialization.dataWithJSONObject(paramString, options: [])
         request.HTTPBody = jsonTodo
         } catch {
         print("Error: cannot create JSON from todo")
         return
         }
         request.HTTPBody = jsonTodo
         */
        
        //let task = session.dataTaskWithRequest(request)
        
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
            
            // parse the result as JSON, since that's what the API provides
            do {
                guard let receivedTodo = try NSJSONSerialization.JSONObjectWithData(responseData,
                                                                                    options: []) as? [String: AnyObject] else {
                                                                                        print("Could not get JSON from responseData as dictionary")
                                                                                        return
                }
                if ((receivedTodo["id"] as? String) != nil){
                    print("Update seccsessfull")
                }else {
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
    
    
}
