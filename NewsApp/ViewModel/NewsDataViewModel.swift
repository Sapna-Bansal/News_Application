//
//  NewsDataViewModel.swift
//  NewsApp
//
//  Created by Sapna Bansal on 06/02/21.
//  Copyright © 2021 Sapna Bansal. All rights reserved.
//
import UIKit
import Foundation
import AlamofireImage
import SDWebImage
class NewsDataViewModel: NSObject,UITableViewDelegate,UITableViewDataSource {
    var catagaryArray = [Article]()
    var response:NewsDataModel? = nil

    var controler = UIViewController()
    var sectionData = ["Top News", "Popular News"]
    var currentPage = 1
    var totalPage = 2
    func numberOfSections(in tableView: UITableView) -> Int{
        return sectionData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0) ? 1 : catagaryArray.count-1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionData[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0){
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TopNewsCellTVC") as? TopNewsCellTVC else { return UITableViewCell() }
             let modelObj = catagaryArray[indexPath.row]
            cell.LblTitle.text = modelObj.title
            cell.LBLDes.text = modelObj.articleDescription
            cell.ImgThumbNail.backgroundColor = .black
            cell.LblSource.text = modelObj.source?.name
            cell.ImgThumbNail.setImage(image: modelObj.urlToImage ?? "")
            cell.BtnBookMark.tag = indexPath.row
            cell.catagaryArray = modelObj
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PopularNewsTVC") as? PopularNewsTVC else { return UITableViewCell() }
            let modelObj = catagaryArray[indexPath.row+1]
            cell.LblTitle.text = modelObj.title
            cell.LBLDes.text = modelObj.articleDescription
            cell.ImgThumbNail.backgroundColor = .black
            cell.LblSource.text = modelObj.source?.name
            cell.ImgThumbNail.setImage(image: modelObj.urlToImage ?? "")
            cell.BtnBookMark.tag = indexPath.row
            cell.catagaryArray = modelObj

            return cell
        }
        
    }
    func removeSpecialCharsFromString(text: String) -> String {
        let okayChars : Set<Character> =
            Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-*=(),.:!_")
        return String(text.filter {okayChars.contains($0) })
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (indexPath.section == 0) ? 420 : 130
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let subCategoryController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController

        subCategoryController.detailResponse = response
        subCategoryController.currentIndex = indexPath.row+1
        controler.navigationController?.pushViewController(subCategoryController, animated: true)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
        if (indexPath.row == 5){
            if currentPage < totalPage{
                //currentPage += 1
                NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: nil)

            }
        }
    }
}
