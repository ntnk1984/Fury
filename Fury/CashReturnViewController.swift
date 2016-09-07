//
//  CashReturnViewController.swift
//  Fury
//
//  Created by Nguyen Khang on 9/3/16.
//  Copyright © 2016 kstorevn. All rights reserved.
//

import UIKit

class CashReturnViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

    @IBOutlet weak var lblTongTien: UILabel!
    var shippingList = [Shipping]()
    var selectedList = [Shipping]()
    
    let identifier = "cell_id"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.delegate = self
        
        self.collectionView.allowsMultipleSelection = true
        
        getShippingForCashReturn()
        
        
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

                        //ord.ngay_dat = (dic as! NSDictionary)["nguoi_dat"] as? String
                        ord.tri_gia = (dic as! NSDictionary)["tri_gia"] as? Float
                        
                        self.shippingList.append(ord)
                     }
                    
                    self.collectionView.reloadData()

                    
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
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.shippingList.count
    }
    
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! CashCollectionViewCell
        
        
        let currentShipping = shippingList[indexPath.row]
        cell.lblSo_hieu.text = currentShipping.so_hieu
        //cell.lblNgayGui.text = currentShipping.ngay_gui
        cell.lblTongCong.text = NSNumberFormatter.localizedStringFromNumber(currentShipping.tri_gia!, numberStyle: NSNumberFormatterStyle.DecimalStyle)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let kWhateverHeightYouWant = 50
        return CGSizeMake(collectionView.bounds.size.width, CGFloat(kWhateverHeightYouWant))
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell : UICollectionViewCell = collectionView.cellForItemAtIndexPath(indexPath)!
        cell.backgroundColor = UIColor.redColor()
        
        self.selectedList.append(self.shippingList[indexPath.row])
        
        calAmount()
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let cell : UICollectionViewCell = collectionView.cellForItemAtIndexPath(indexPath)!
        cell.backgroundColor = UIColor.whiteColor()
        
        self.selectedList.removeAtIndex(indexPath.row)
        
        self.calAmount()
    }
    
    func calAmount(){
        var Amount: Float = 0.0
        
        for pu:Shipping in self.selectedList {
            Amount = Amount + pu.tri_gia!
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
