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
    var purchaseList = [Purchase]()
    var selectedList = [Purchase]()
    
    let identifier = "cell_id"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.delegate = self
        
        let p1 = Purchase()
        p1.so_hieu = "156879987654"
        p1.ngay_gui = "2/9/2016"
        p1.tong_cong = 510000
        
        let p2 = Purchase()
        p2.so_hieu = "156879987654"
        p2.ngay_gui = "2/9/2016"
        p2.tong_cong = 510000

        
        
        purchaseList.append(p1)
        purchaseList.append(p2)
        
        self.collectionView.allowsMultipleSelection = true
        self.collectionView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.purchaseList.count
    }
    
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! CashCollectionViewCell
        
        
        let currentPurchase = purchaseList[indexPath.row]
        cell.lblSo_hieu.text = currentPurchase.so_hieu
        cell.lblNgayGui.text = currentPurchase.ngay_gui
        cell.lblTongCong.text = NSNumberFormatter.localizedStringFromNumber(currentPurchase.tong_cong!, numberStyle: NSNumberFormatterStyle.DecimalStyle)
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
        
        self.selectedList.append(self.purchaseList[indexPath.row])
        
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
        
        for pu:Purchase in self.selectedList {
            Amount = Amount + pu.tong_cong!
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
