//
//  MyTableViewCell.swift
//  PhotoApp
//
//  Created by Dondeti, Sai Krishna on 27/07/21.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet var imageData: UIImageView!
    @IBOutlet var albumLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
