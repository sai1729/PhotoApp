//
//  ImageViewController.swift
//  PhotoApp
//
//  Created by Dondeti, Sai Krishna on 27/07/21.
//

import UIKit

class ImageViewController: UIViewController {
    @IBOutlet var imageViewData: UIImageView!
    var ImageUrl: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        imageViewCall()
        self.title = "Image View"
    }
    

    func imageViewCall() {
        let url = URL(string: self.ImageUrl ?? "")!

          // Create Data Task
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
                DispatchQueue.main.async {
                    self.imageViewData?.image = UIImage(data: data)
                }
            }
        }
          dataTask.resume()
    }
}
