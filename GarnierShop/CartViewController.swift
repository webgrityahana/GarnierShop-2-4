//
//  CartViewController.swift
//  GarnierShop
//
//  Created by Anand Baid on 8/24/21.
//

import UIKit

class CartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var arrdata = [jsonstruct]()
    var categorydata = [Categories]()
    var imgdata = [Images]()
    
    var cartArray = [CartStruct]()
    
    @IBOutlet var cartTableView: UITableView!
    
    @IBOutlet var totalCount: UILabel!
    
    @IBOutlet var proceedBtn: UIButton!
    
    @IBOutlet var subtotalPrice: UILabel!
    @IBOutlet var shippingPrice: UILabel!
    @IBOutlet var totalPrice: UILabel!
    
    /*var callback : ((Int)->())?
    var counter1 = 0 {
          didSet {
            prod1Count.text = "\(counter1)"
          }
    }*/
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /*sh1view.layer.cornerRadius = 15
        sh1view.clipsToBounds = true
        
        sub1btn.layer.cornerRadius = sub1btn.frame.width / 2
        sub1btn.layer.cornerRadius = sub1btn.frame.height / 2
        sub1btn.layer.masksToBounds = true
        sub1btn.layer.borderWidth = 1
        sub1btn.layer.borderColor = UIColor.black.cgColor
        
        add1btn.layer.cornerRadius = add1btn.frame.width / 2
        add1btn.layer.cornerRadius = add1btn.frame.height / 2
        add1btn.layer.masksToBounds = true*/
        
        proceedBtn.layer.cornerRadius = 30
        proceedBtn.clipsToBounds = true
    }
    
    @IBAction func proceedBtnTapped(_ sender: Any) {
        showActionsheet()
    }
    
    /*@IBAction func sub1btnTapped(_ sender: Any) {
        if counter1 > 0 { counter1 -= 1 }
        callback?(counter1)
    }
    
    @IBAction func add1btnTapped(_ sender: Any) {
        counter1 += 1
        callback?(counter1)
    }*/
    
    
    func showActionsheet() {
        let actionsheet = UIAlertController(title: "Select Payment Method", message: nil, preferredStyle: .actionSheet)
        
        //let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        //actionsheet.addAction(cancelAction)
        
        actionsheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        let action1 = UIAlertAction(title: "Paypal", style: .default, handler: { action1 in print("tapped Dismiss")
        })
        
        let image1 = UIImage(named: "Image 18.png")
        action1.setValue(image1?.withRenderingMode(.alwaysOriginal), forKey: "image")
        actionsheet.addAction(action1)
        
        let action2 = UIAlertAction(title: "Credit or Debit Card", style: .default, handler: { action2 in //print("tapped Dismiss")
            let storyboard      =   UIStoryboard(name: "Main", bundle: nil)
            let paymentVC   =   storyboard.instantiateViewController(withIdentifier: "PaymentViewController") as! PaymentViewController
            //paymentVC.orderId     =   self.myDraftOrders[indexPath.row]["id"].intValue
            self.navigationController?.pushViewController(paymentVC, animated: true)
        })
        let image2 = UIImage(named: "Image 20.png")
        action2.setValue(image2?.withRenderingMode(.alwaysOriginal), forKey: "image")
        actionsheet.addAction(action2)
        
        let action3 = UIAlertAction(title: "Apple Pay", style: .default, handler: { action3 in print("tapped Dismiss")
        })
        let image3 = UIImage(named: "Image 19.png")
        action3.setValue(image3?.withRenderingMode(.alwaysOriginal), forKey: "image")
        actionsheet.addAction(action3)
     
        actionsheet.view.backgroundColor = .white
        
        actionsheet.view.layer.cornerRadius = 15
        actionsheet.view.clipsToBounds = true
        
        present(actionsheet, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "CartCellTableViewCell", for: indexPath) as? CartCellTableViewCell
        
        //cell?.productNameCart.text = arrdata[indexPath.row].name
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCellTableViewCell", for: indexPath) as! CartCellTableViewCell
        
        //cell.cartImageView.downloadImage(from: (self.cartArray[indexPath.item].images.first?.src)!)
        
        //cell.cartImageView.downloadImage(from: cartArray[indexPath.row].cartItems.images.first?.src ?? "place_holder_image")
        //cell.productNameCart.text = arrdata[indexPath.row].name
        cell.productNameCart.text = cartArray[indexPath.row].cartItems.first?.name
        //cell.prodductDescCart.text = cartArray[indexPath.row].cartItems.first?.shortDescription
        //cell.productPriceCart.text = cartArray[indexPath.row].cartItems.price
        
        //cell.addBtn.addTarget(self, action: #selector(add(sender:)), for: .touchUpInside)
        cell.addBtn.tag = indexPath.row
        //let cartQuantity = cartArray[indexPath.row].cartQuantity
        //cell.prodCount.text = "\(cartQuantity)"
        //if cartQuantity > 1 {
            cell.subBtn.isUserInteractionEnabled = true;
            //cell.subBtn.addTarget(self, action: #selector(sub(sender:)), for: .touchUpInside)
            cell.subBtn.tag = indexPath.row
        //} else {
            cell.subBtn.isUserInteractionEnabled = false;
        //}
        
        return cell
    }
    
}












