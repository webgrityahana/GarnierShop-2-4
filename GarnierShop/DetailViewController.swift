//
//  DetailViewController.swift
//  GarnierShop
//
//  Created by Anand Baid on 8/21/21.
//

import UIKit

struct CartStruct {
    var cartItems: jsonstruct
    var cartQuantity: Int
}

class DetailViewController: UIViewController {
    
    var arrdata = [jsonstruct]()
    var categorydata = [Categories]()
    var imgdata = [Images]()
    
    var detailInfo: jsonstruct?
    var cartArray = [CartStruct]()
    
    @IBOutlet weak var prodName: UILabel!
    @IBOutlet weak var probName2: UILabel!
    @IBOutlet weak var prodSHDesc: UILabel!
    @IBOutlet weak var prodDesc: UILabel!
    @IBOutlet weak var prodPrice: UILabel!
    @IBOutlet weak var probImage: UIImageView!
    @IBOutlet var container: UIView!
    @IBOutlet var ratingView: UIView!
    @IBOutlet var addToCartbtn: UIView!
    @IBOutlet var one: UIView!
    @IBOutlet var two: UIView!
    @IBOutlet var three: UIView!
    @IBOutlet var imgone: UIImageView!
    @IBOutlet var imgtwo: UIImageView!
    @IBOutlet var imgthree: UIImageView!
    @IBOutlet var cart4View: UIView!
    @IBOutlet var cartCount: UILabel!
    
    
    var Image = UIImage()
    var Name = ""
    var Name2 = ""
    var SH_desc = ""
    var Desc = ""
    var Price = ""
    var Img1 = UIImage()
    var Img2 = UIImage()
    var Img3 = UIImage()
    
    
    var callback : ((Int)->())?
    var counter1 = 0 {
        didSet {
            cartCount.text = "\(counter1)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        probImage.layer.cornerRadius = 15
        probImage.clipsToBounds = true
        
        container.layer.cornerRadius = 50
        container.clipsToBounds = true
        
        ratingView.layer.cornerRadius = 20
        ratingView.clipsToBounds = true
        ratingView.layer.borderWidth = 1
        ratingView.layer.borderColor = UIColor.lightGray.cgColor
        
        addToCartbtn.layer.cornerRadius = 20
        addToCartbtn.clipsToBounds = true
        
        one.layer.cornerRadius = 15
        one.clipsToBounds = true
        one.layer.borderWidth = 1
        one.layer.borderColor = UIColor.lightGray.cgColor
        
        two.layer.cornerRadius = 15
        two.clipsToBounds = true
        two.layer.borderWidth = 1
        two.layer.borderColor = UIColor.lightGray.cgColor
        
        three.layer.cornerRadius = 15
        three.clipsToBounds = true
        three.layer.borderWidth = 1
        three.layer.borderColor = UIColor.lightGray.cgColor
        
        cart4View.layer.cornerRadius = cart4View.frame.width / 2
        cart4View.layer.cornerRadius = cart4View.frame.height / 2
        cart4View.layer.masksToBounds = true
        self.updateUI()
    }
    
    func updateUI(){
        if let detailInfo = detailInfo {
            if let urlString = detailInfo.images.first?.src {
                self.probImage.downloadImage(from: urlString)
            }
            
            prodName.text = detailInfo.name
            probName2.text = detailInfo.name
            prodSHDesc.text = detailInfo.categories.first!.type
            prodDesc.text = detailInfo.description
            prodPrice.text = detailInfo.price
            
            let imagesArray = detailInfo.images
            
            
            if imagesArray.count > 0{
                self.probImage.downloadImage(from: detailInfo.images[0].src)
                self.imgone.downloadImage(from: detailInfo.images[0].src)
            }
            
            if imagesArray.count > 1 {
                self.imgtwo.downloadImage(from: detailInfo.images[1].src)
            }
            
            if imagesArray.count > 2 {
                self.imgthree.downloadImage(from: detailInfo.images[2].src)
            }
        }
    }
    
    @IBAction func firstImgBtnTapped(_ sender: Any) {
        if let imageURL = detailInfo?.images[0].src {
            probImage.downloadImage(from: imageURL)
        }
    }
    
    @IBAction func secondImgBtnTapped(_ sender: Any) {
        if let imageURL = detailInfo?.images[1].src {
            probImage.downloadImage(from: imageURL)
        }
    }
    
    @IBAction func thirdImgBtnTapped(_ sender: Any) {
        if let imageURL = detailInfo?.images[2].src {
            probImage.downloadImage(from: imageURL)
        }
    }
    
    @IBAction func cartTappedToNavigate(_ sender: Any) {
        let cart = self.storyboard?.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController
        
        //detail?.Name = arrdata[indexPath.row].name
        cart?.cartArray = cartArray
        
        self.navigationController?.pushViewController(cart!, animated: true)
    }
    
    @IBAction func addToCartbtnTapped(_ sender: Any) {
        if let info = detailInfo {
            cartArray.append(CartStruct(cartItems: info, cartQuantity: 1))
            cartCount.text = "\(cartArray.count)"
            showAlert()
            (sender as AnyObject).setTitle("Go to Cart", for: .normal)
            addToCartbtn.isUserInteractionEnabled = false
        }
        /*showAlert()
         counter1 += 1
         callback?(counter1)
         (sender as AnyObject).setTitle("Go to Cart", for: .normal)
         addToCartbtn.isUserInteractionEnabled = false*/
        //let cart = self.storyboard?.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController
        //self.navigationController?.pushViewController(cart!, animated: true)
        
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Item Added to Cart", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
