//
//  CommonClass.swift
//  NewsApp
//
//  Created by Sapna Bansal on 06/02/21.
//  Copyright © 2021 Sapna Bansal. All rights reserved.
//

import UIKit

extension UIView {
    func setViewLayout(cornerRadius:CGFloat,backgorundcolor:UIColor) {
        self.backgroundColor = backgorundcolor
        layer.cornerRadius = cornerRadius
        clipsToBounds = false
    }
}
extension UIImageView{
    func setImage(image:String){
        let allowedCharacters = NSCharacterSet.urlQueryAllowed as! NSMutableCharacterSet
        if let encodedImage = image.addingPercentEncoding(withAllowedCharacters: allowedCharacters as CharacterSet) {
            if (encodedImage==""){
                self.image = UIImage(named: "Bitmap Copy 4.png")//af.setImage(withURL: URL(string: modelObj.urlToImage!)!)

            }else{
            self.af.setImage(withURL:URL(string:encodedImage)!)
            }
            /* use encodedImage here */
        } else {
            /* stringByAddingPercentEncodingWithAllowedCharacters failed for some reason */
         self.image = UIImage(named: "Bitmap Copy 4.png")//af.setImage(withURL: URL(string: modelObj.urlToImage!)!)

        }
    }
}
