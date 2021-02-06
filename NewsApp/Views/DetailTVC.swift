//
//  DetailTVC.swift
//  NewsApp
//
//  Created by Sapna Bansal on 06/02/21.
//  Copyright © 2021 Sapna Bansal. All rights reserved.
//

import UIKit

class DetailTVC: UITableViewCell {

    @IBOutlet weak var ImgThumbNail: UIImageView!
      @IBOutlet weak var LblTitle: UILabel!
      @IBOutlet weak var LBLDes: UILabel!
      @IBOutlet weak var ViewSourceVw: UIView!
      @IBOutlet weak var LblSource: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
