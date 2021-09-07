//
//  CellTableViewCell.swift
//  GarnierShop
//
//  Created by Anand Baid on 8/20/21.
//

import UIKit

class CellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSHDesc: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var lblimg: UILabel!
    @IBOutlet weak var lblhrt: UILabel!
    @IBOutlet weak var lblbuy: UILabel!
    @IBOutlet var cellContentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblimg.layer.cornerRadius = 15
        lblimg.clipsToBounds = true
        
        lblhrt.layer.cornerRadius = lblhrt.frame.width / 2
        lblhrt.layer.cornerRadius = lblhrt.frame.height / 2
        lblhrt.layer.masksToBounds = true
        
        lblbuy.layer.cornerRadius = 15
        lblbuy.clipsToBounds = true
        
        img.layer.cornerRadius = 15
        img.clipsToBounds = true
        
        cellContentView.layer.cornerRadius = 50
        cellContentView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
