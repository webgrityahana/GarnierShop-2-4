//
//  ViewController.swift
//  GarnierShop
//
//  Created by Anand Baid on 8/11/21.
//

import UIKit
import Alamofire
import OAuthSwift
import SwiftyJSON

struct jsonstruct: Codable {
    let name: String
    let catalog_visibility: String
    let short_description: String
    let description: String
    let price: String
    let categories: [Categories]
    let images: [Images]
    
    enum CodingKeys: String, CodingKey {
        case name
        case catalog_visibility
        case short_description
        case description
        case price
        case categories
        case images
    }
}

struct Categories: Codable {
    let type: String
    
    enum  CodingKeys: String, CodingKey {
        case type = "name"
    }
}

struct Images: Codable {
    let src: String
}

class ViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var cartview: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var searchbar: UISearchBar!
    @IBOutlet var itemCount: UILabel!
    
    var imgdata = [Images]()
    var categorydata = [Categories]()
    var arrdata = [jsonstruct]()
    
    var detailInfo: jsonstruct?
    var cartArray = [CartStruct]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let value = UserDefaults.standard.string(forKey: "CountAddedProducts")
        
        if value != nil {
            itemCount.text = value
        }
        else {
            itemCount.text = "0"
        }
        
        cartview.layer.cornerRadius = cartview.frame.width / 2
        cartview.layer.cornerRadius = cartview.frame.height / 2
        cartview.layer.masksToBounds = true
        
        tableView.layer.cornerRadius = 15
        tableView.clipsToBounds = true
        
        self.searchbar.endEditing(true)
        
        //self.tableView.keyboardDismissMode = .onDrag
        
        //let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        //view.addGestureRecognizer(tap)
        
        getdata()
    }
    
    @IBAction func cartBtnTapped(_ sender: Any) {
        let detail = self.storyboard?.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController
        detail?.cartArray = cartArray
        self.navigationController?.pushViewController(detail!, animated: true)
    }
    
    
    //@IBAction func HideKeyboard(_ sender: UITapGestureRecognizer) {
        //self.searchbar.resignFirstResponder()
    //}
    
    //func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //searchbar.resignFirstResponder() // hides the keyboard.
        //doThingsForSearching()
    //}
    
    //@objc func handleTap() {
        //searchbar.resignFirstResponder() // dismiss keyoard
    //}
        
    
    func getdata() {
        
        let url = URL(string: "https://mywebstaging.net/ab/garnier/wp-json/wc/v3/products?consumer_key=ck_4a6a758693004efa43ad311d18b30461e6a03d1f&consumer_secret=cs_41a3324c8f8e950ca75764872ae91ea4e5c9b85b")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do{if error == nil{
                self.arrdata = try JSONDecoder().decode([jsonstruct].self, from: data!)

                    print(self.arrdata)
                    DispatchQueue.main.async {
                         self.tableView.reloadData()
                    }
                }
            
            }catch{
                print("Error in get json data")
            }
            
        }.resume()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrdata.count
     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CellTableViewCell
        //cell.lblname?.text = "Name : \(arrdata[indexPath.row].name)"
        //cell?.lblname.text = "Name: " + arrdata[indexPath.row].name
        
        cell?.img.downloadImage(from: (self.arrdata[indexPath.item].images.first?.src)!)

        cell?.lblName.text = arrdata[indexPath.row].name
        cell?.lblSHDesc.text = arrdata[indexPath.row].categories.first?.type
        cell?.lblDesc.text = arrdata[indexPath.row].short_description
        cell?.lblPrice.text = arrdata[indexPath.row].price
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        detail?.detailInfo = arrdata[indexPath.row]
        self.navigationController?.pushViewController(detail!, animated: true)
    }
}

extension UIImageView {
    func downloadImage(from url: String) {
        let urlRequest = URLRequest(url: URL(string: url)!)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data,response,error) in
            if error != nil {
                print("error")
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
        task.resume()
    }
}



