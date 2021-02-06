//
//  TopNewsCellTVC.swift
//  NewsApp
//
//  Created by Sapna Bansal on 06/02/21.
//  Copyright © 2021 Sapna Bansal. All rights reserved.
//

import UIKit

class TopNewsCellTVC: UITableViewCell {

    @IBOutlet weak var ImgThumbNail: UIImageView!
    @IBOutlet weak var LblTitle: UILabel!
    @IBOutlet weak var LBLDes: UILabel!
    @IBOutlet weak var ViewSourceVw: UIView!
    @IBOutlet weak var LblSource: UILabel!
    @IBOutlet weak var BtnBookMark: UIButton!
    var catagaryArray:Article? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ViewSourceVw.setViewLayout(cornerRadius: ViewSourceVw.frame.height/2,backgorundcolor: .systemGray6)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func bookMArkAction(_ sender: UIButton) {
        let modelObj = catagaryArray
        if catagaryArray?.title != nil{
            if (delegate?.bookmarkArrayList.contains(where: { $0.title == catagaryArray?.title }))! {
             // found
                BtnBookMark.setImage(#imageLiteral(resourceName: "unselected_bookmark"), for: .normal)
                 delegate?.bookmarkArrayList.remove(at: sender.tag)
        } else {
             // not
                BtnBookMark.setImage(#imageLiteral(resourceName: "selected_BookMark"), for: .normal)
                delegate?.bookmarkArrayList.append(modelObj!)
         }
        }
    }
    
}
