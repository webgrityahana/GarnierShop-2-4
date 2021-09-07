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
    
    //var name = ["Garnier Face Scrubber", "Garnier Body Syrum", "Garnier Body Milk", "Garnier Face Mask", "Garnier Face Wash"]
    //var image = ["G1.jpeg", "G2.jpeg", "G3.jpeg", "G4.jpeg", "G5.jpeg"]
    //var category = ["Face Product", "Body Product", "Body Product", "Face Product", "Face Product"]
    //var desc = ["incididunt magna duis ut adipisicing mollit esse id mollit quis aliquip laboris nostrud", "sit aute id eu elit sunt consectetur incididunt in duis laboris magna adipisicing irure dolore reprehenderit", "duis tempor voluptate sunt duis esse exercitation ut nostrud adipisicing", "magna duis ut adipisicing mollit esse id mollit quis aliquip laboris nostrud consequat", "Amet ut nisi aute cupidatat ut voluptate ut duis tempor tempor laborum sint dolor sed excepteur"]
    //var desc2 = ["incididunt magna duis ut adipisicing mollit esse id mollit quis aliquip laboris nostrud consequat officia laboris minim cupidatat esse tempor velit sed deserunt in cillum minim sint id voluptate nisi sint anim nostrud ex nostrud sunt sit ullamco veniam ut sed nisi proident velit excepteur voluptate ad consectetur aliqua et laboris aliquip nisi pariatur exercitation.", "sit aute id eu elit sunt consectetur incididunt in duis laboris magna adipisicing irure dolore reprehenderit consequat eiusmod dolore est ad culpa anim minim voluptate sint eu mollit aliquip mollit adipisicing dolor amet officia officia aliquip cillum laboris.sit aute id eu elit sunt consectetur incididunt in duis laboris magna adipisicing irure dolore reprehenderit consequat eiusmod dolore est ad culpa anim minim voluptate sint eu mollit aliquip mollit adipisicing dolor amet officia officia aliquip cillum laboris.", "duis tempor voluptate sunt duis esse exercitation ut nostrud adipisicing aute et consequat aute labore eu mollit dolor cupidatat sit aute id eu elit sunt consectetur incididunt in duis laboris magna duis tempor voluptate sunt duis esse exercitation ut nostrud adipisicing aute et consequat aute labore eu mollit dolor cupidatat sit aute id eu elit sunt consectetur incididunt in duis laboris magna", "magna duis ut adipisicing mollit esse id mollit quis aliquip laboris nostrud consequat officia laboris minim cupidatat esse tempor velit sed deserunt in cillum minim sint id voluptate nisi sint anim nostrud ex nostrud sunt sit ullamco veniam ut sed nisi proident velit excepteur voluptate ad", "Amet ut nisi aute cupidatat ut voluptate ut duis tempor tempor laborum sint dolor sed excepteur reprehenderit irure ullamco consequat et dolor consequat nulla quis ad veniam mollit quis elit commodo dolore sed laboris fugiat do sed ea amet nulla sit aute ullamco sit ullamco labore quis consectetur ad labore id ea voluptate ullamco ad aute occaecat nostrud esse quis fugiat officia eiusmod reprehenderit ex aliquip nisi aute eu in amet dolor dolore dolore esse et amet dolore reprehenderit esse in elit quis est ut"]
    
    //var price = ["$10.00", "$50.00", "$20.00", "$35.00", "$10.00"]
    
    //var image2 = ["G12.jpeg", "G22.jpeg", "G32.jpeg", "G42.jpeg", "G52.jpeg"]
    //var image3 = ["G13.jpeg", "G23.jpeg", "G33.jpeg", "G43.jpeg", "G53.jpeg"]
    

    @IBOutlet weak var cartview: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var searchbar: UISearchBar!
    
    var imgdata = [Images]()
    
    var categorydata = [Categories]()
    
    var arrdata = [jsonstruct]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                    //print(self.arrdata[0].categories.name)
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
        
        //cell?.img.image = try UIImage(data: Data(contentsOf: URL(string: arrdata[indexPath.row].src!) ?? URL(string: "http://www.google.com")!))

        //cell?.img.downloadImage(from: (self.arrdata[indexPath.item].src)!)
        //cell?.img.image = UIImage(named: image[indexPath.row])!
        cell?.lblName.text = arrdata[indexPath.row].name
        cell?.lblSHDesc.text = arrdata[indexPath.row].categories.first?.type
        cell?.lblDesc.text = arrdata[indexPath.row].short_description
        cell?.lblPrice.text = arrdata[indexPath.row].price

        /*if let imageURL = URL(string: arrdata[indexPath.row].src) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell?.img.image = image
                    }
                }
            }
        }*/
        
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



