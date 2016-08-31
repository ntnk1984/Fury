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
        
        
        
        self.data_request()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func data_request()
    {
        let url:NSURL = NSURL(string: String(format: "%@%@", Constants.baseUrl, "Orders"))!
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        let id = NSUUID()
        
        let paramString = String(format: "id=%@&ngay_dat=%@&ma_sp=&so_luong=%@&mau_sac=&gia_ban_le=%@&tien_ship=%@&tong_cong=%@&nguoi_dat=%@&dien_thoai=%@&trang_thai=1&dia_chi=%@&cong_doan=1", id, ngaydatTextField.text!, soluongTextField!, giabanleTextField.text!, tienshipTextField.text!, tongcongTextField.text!, nguoidatTextField.text!, dienthoaiTextField.text!, diachiTextField.text!)
        request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = session.dataTaskWithRequest(request) {
            (
            let data, let response, let error) in
            
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                print("error")
                return
            }
            
            let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print(dataString)
            
        }
        
        task.resume()
        
    }

}

