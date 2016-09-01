//
//  FirstViewController.swift
//  Fury
//
//  Created by Nguyen Khang on 8/31/16.
//  Copyright © 2016 kstorevn. All rights reserved.
//

import UIKit


class FirstViewController: UIViewController {

    @IBOutlet weak var ngaydatTextField: UITextField!
    
    @IBOutlet weak var soluongTextField: UITextField!
    @IBOutlet weak var giabanleTextField: UITextField!
    
    @IBOutlet weak var dienthoaiTextField: UITextField!
    @IBOutlet weak var nguoidatTextField: UITextField!
    
    @IBOutlet weak var diachiTextField: UITextField!
    
    @IBOutlet weak var tienshipTextField: UITextField!
    
    @IBOutlet weak var tongcongTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        
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
                print("The todo is: " + receivedTodo.description)
                
                guard let todoID = receivedTodo["id"] as? String else {
                    print("Could not get todoID as int from JSON")
                    return
                }
                print("The ID is: \(todoID)")
            } catch  {
                print("error parsing response from POST on /todos")
                return
            }
        }
 
        task.resume()
    }
    
    

}

