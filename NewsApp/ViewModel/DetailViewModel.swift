//
//  DetailViewModel.swift
//  NewsApp
//
//  Created by Sapna Bansal on 06/02/21.
//  Copyright © 2021 Sapna Bansal. All rights reserved.
//
import UIKit
import Foundation
import AlamofireImage
class DetailViewModel: NSObject,UITableViewDelegate,UITableViewDataSource {
    var catagaryArraya = [Article]()
    var controler = UIViewController()
    var sectionData = ["Popular News"]
    func numberOfSections(in tableView: UITableView) -> Int{
        return sectionData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catagaryArraya.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionData[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "PopularNewsTVC") as? PopularNewsTVC else { return UITableViewCell() }
            let modelObj = catagaryArraya[indexPath.row+1]
            cell.LblTitle.text = modelObj.title
            cell.LBLDes.text = modelObj.articleDescription
            cell.ImgThumbNail.backgroundColor = .black
            cell.LblSource.text = modelObj.source?.name
            cell.ImgThumbNail.setImage(image: modelObj.urlToImage ?? "")
       return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
  
}
