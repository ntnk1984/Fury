//
//  FirstViewController.swift
//  Fury
//
//  Created by Nguyen Khang on 8/31/16.
//  Copyright © 2016 kstorevn. All rights reserved.
//

import UIKit


class OrderViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var ngaydatTextField: UITextField!
    
    @IBOutlet weak var soluongTextField: UITextField!
    @IBOutlet weak var giabanleTextField: UITextField!
    
    @IBOutlet weak var dienthoaiTextField: UITextField!
    @IBOutlet weak var nguoidatTextField: UITextField!
    
    @IBOutlet weak var diachiTextField: UITextField!
    
    @IBOutlet weak var tienshipTextField: UITextField!
    
    @IBOutlet weak var tongcongTextField: UITextField!
    
    var datePicker: UIDatePicker!
    
    /*
    override func viewWillAppear(animated: Bool) {
        self.startKeyboardObserver()
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.stopKeyboardObserver()
    }
    
    
    private func startKeyboardObserver(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil) //WillShow and not Did ;) The View will run animated and smooth
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    private func stopKeyboardObserver() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardSize: CGSize =    userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue().size {
                let contentInset = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height,  0.0);
                
                self.scrollView.contentInset = contentInset
                self.scrollView.scrollIndicatorInsets = contentInset
                
                self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, 0 + keyboardSize.height) //set zero instead self.scrollView.contentOffset.y
                
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        let contentInset = UIEdgeInsetsZero;
        
        self.scrollView.contentInset = contentInset
        self.scrollView.scrollIndicatorInsets = contentInset
        self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, self.scrollView.contentOffset.y)
    }
    */
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func ngaydatEdit(sender: UITextField) {
        /*
        datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.Date
        sender.inputView = datePicker
        datePicker.addTarget(self, action: "datePickerChanged:", forControlEvents: .ValueChanged)
        */
        
        //Create the view
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
        ngaydatTextField.text = dateFormatter.stringFromDate(sender.date)
    }
    
    func doneButton(sender:UIButton)
    {
        datePicker.resignFirstResponder()
        ngaydatTextField.resignFirstResponder()
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField == tongcongTextField || textField == tienshipTextField {
            scrollView.setContentOffset(CGPointMake(0, 50), animated: true)
        }
        
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        scrollView.setContentOffset(CGPointMake(0, 0), animated: true)
    }
    
    func closeKeyboard(){
        self.view.endEditing(true)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        closeKeyboard()
        datePicker.removeFromSuperview()
    }
    
    func datePickerChanged(sender: UIDatePicker) {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        ngaydatTextField.text = formatter.stringFromDate(sender.date)
        self.view.endEditing(true)
        datePicker.removeFromSuperview()
    }
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ngaydatTextField.delegate = self
        soluongTextField.delegate = self
        nguoidatTextField.delegate = self
        diachiTextField.delegate = self
        dienthoaiTextField.delegate = self
        giabanleTextField.delegate = self
        tienshipTextField.delegate = self
        tongcongTextField.delegate = self
        
        
        
    }
   
    
    @IBAction func addPO(sender: UIButton) {
        self.data_request()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func data_request()
    {
        let url:NSURL = NSURL(string: String(format: "%@%@", Constants.baseUrl, "Orders"))!
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
    print(url)
        let session = NSURLSession(configuration: config)
        
        let request = NSMutableURLRequest(URL: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "POST"
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
        
        let data:String = String(format: "{\"id\":\"%@\" , \"ngay_dat\":\"%@\" , \"ma_sp\":\"\" , \"so_luong\": %@, \"mau_sac\":\"\", \"gia_ban_le\":%@, \"tien_ship\": %@, \"tong_cong\":%@, \"nguoi_dat\":\"%@\", \"dien_thoai\":\"%@\", \"trang_thai\":\"0\", \"dia_chi\":\"%@\", \"cong_doan\":\"1\"}", NSUUID().UUIDString, ngaydatTextField.text!, soluongTextField.text!, giabanleTextField.text!, tienshipTextField.text!, tongcongTextField.text!, nguoidatTextField.text!, dienthoaiTextField.text!, diachiTextField.text!)
            
        
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
                    self.ngaydatTextField.text = ""
                    self.soluongTextField.text = ""
                    self.nguoidatTextField.text = ""
                    self.diachiTextField.text = ""
                    self.dienthoaiTextField.text = ""
                    self.giabanleTextField.text = ""
                    self.tienshipTextField.text = ""
                    self.tongcongTextField.text = ""
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

