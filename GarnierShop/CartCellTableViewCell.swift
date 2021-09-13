//
//  CartCellTableViewCell.swift
//  GarnierShop
//
//  Created by Anand Baid on 9/3/21.
//

import UIKit

class CartCellTableViewCell: UITableViewCell {
    
    @IBOutlet var cartImageView: UIImageView!
    @IBOutlet var productNameCart: UILabel!
    @IBOutlet var prodductDescCart: UILabel!
    @IBOutlet var productPriceCart: UILabel!
    @IBOutlet var subBtn: UIButton!
    @IBOutlet var prodCount: UILabel!
    @IBOutlet var addBtn: UIButton!
    @IBOutlet var imageFrame: UIView!
    
    /*var callback : ((Int)->())?
    var counter1 = 0 {
          didSet {
            prodCount.text = "\(counter1)"
          }
    }*/
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageFrame.layer.cornerRadius = 15
        imageFrame.clipsToBounds = true
        
        subBtn.layer.cornerRadius = subBtn.frame.width / 2
        subBtn.layer.cornerRadius = subBtn.frame.height / 2
        subBtn.layer.masksToBounds = true
        subBtn.layer.borderWidth = 1
        subBtn.layer.borderColor = UIColor.black.cgColor
        
        addBtn.layer.cornerRadius = addBtn.frame.width / 2
        addBtn.layer.cornerRadius = addBtn.frame.height / 2
        addBtn.layer.masksToBounds = true
    }
    
    /*@IBAction func subBtnTapped(_ sender: Any) {
        if counter1 > 0 { counter1 -= 1 }
        callback?(counter1)
    }
    
    @IBAction func addBtnTapped(_ sender: Any) {
        counter1 += 1
        callback?(counter1)
    }*/
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
