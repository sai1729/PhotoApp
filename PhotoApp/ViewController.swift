//
//  ViewController.swift
//  PhotoApp
//
//  Created by Dondeti, Sai Krishna on 27/07/21.
//

import UIKit
import Alamofire
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath) as! MyTableViewCell
        tableDic = self.resultArr[indexPath.row] as! NSDictionary
        
        print(self.tableDic)
        
        cell.albumLabel.text = tableDic["title"] as? String
        
        let url = URL(string: (self.tableDic["thumbnailUrl"] as? String)!)

          // Create Data Task
        let dataTask = URLSession.shared.dataTask(with: url!) { (data, _, _) in
            if let data = data {
                DispatchQueue.main.async {
                    cell.imageView?.image = UIImage(data: data)
                }
            }
        }
          dataTask.resume()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = self.resultArr[indexPath.row] as! NSDictionary
        let url = selectedUser["url"] as? String
        let imageViewController = self.storyboard?.instantiateViewController(withIdentifier: "ImageView") as! ImageViewController
        imageViewController.ImageUrl = url
        let navController = UINavigationController(rootViewController: imageViewController)
        self.present(navController, animated:true, completion: nil)
    }
    
    @IBOutlet var listView: UITableView!
    var resultArr : NSArray = []
    var tableDic : NSDictionary = NSDictionary()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        listView.register(UINib(nibName: "MyTableViewCell", bundle: nil), forCellReuseIdentifier: "cellIdentifier")
        self.call()
    }
    
    func call(){
        print("request Called")
        AF.request("http://jsonplaceholder.typicode.com/photos", method: .get,parameters: nil, encoding: JSONEncoding.default).responseJSON { response in
            debugPrint(response)
            switch response.result {
            case .success:
                self.resultArr = []
                if let JSON:NSArray = response.value  as! NSArray? {
                    self.resultArr = JSON
                    self.resultArr.adding(JSON)
                    print(self.resultArr.count)
                    print("JSON: \(JSON)")
                    self.listView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error)")
                if (error._code == -1005){
                    self.call()
                }else{
                    print("Try again")
                }
            }
        }
    }


}

