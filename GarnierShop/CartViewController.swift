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
    @IBOutlet var subtotalPrice: UILabel!
    @IBOutlet var shippingPrice: UILabel!
    @IBOutlet var totalPrice: UILabel!
    @IBOutlet var proceedBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getCartData()

        proceedBtn.layer.cornerRadius = 30
        proceedBtn.clipsToBounds = true
    }
    
    func getCartData() {
           let defaults = UserDefaults.standard
           if let data = defaults.data(forKey: "cartt") {
               cartArray = try! PropertyListDecoder().decode([CartStruct].self, from: data)
               cartTableView.reloadData()
           }
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
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let paymentVC = storyboard.instantiateViewController(withIdentifier: "PaymentViewController") as! PaymentViewController
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
        return cartArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCellTableViewCell", for: indexPath) as! CartCellTableViewCell
 
        cell.cartImageView.downloadImage(from: cartArray[indexPath.row].cartItems.images.first?.src ?? "place_holder_image")

        cell.productNameCart.text = cartArray[indexPath.row].cartItems.name
        cell.prodductDescCart.text = cartArray[indexPath.row].cartItems.categories.first?.type
        cell.productPriceCart.text = cartArray[indexPath.row].cartItems.price
        
        cell.addBtn.addTarget(self, action: #selector(add(sender:)), for: .touchUpInside)
        cell.addBtn.tag = indexPath.row
        
        let cartQuantity = cartArray[indexPath.row].cartQuantity
        cell.prodCount.text = "\(cartQuantity)"
        
        if cartQuantity >= 0 {
            cell.subBtn.isUserInteractionEnabled = true;
            cell.subBtn.addTarget(self, action: #selector(sub(sender:)), for: .touchUpInside)
            cell.subBtn.tag = indexPath.row
        } else {
            cell.subBtn.isUserInteractionEnabled = false;
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cartArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }
    
    @objc func add(sender: UIButton){
        if cartArray[sender.tag].cartQuantity >= 0 {
            cartArray[sender.tag].cartQuantity += 1
            cartTableView.reloadData()
        }
    }
    
    @objc func sub(sender: UIButton){
        if cartArray[sender.tag].cartQuantity > 0 {
            cartArray[sender.tag].cartQuantity -= 1
            cartTableView.reloadData()
        }
    }
}












