//
//  BookMarkViewController.swift
//  NewsApp
//
//  Created by Sapna Bansal on 06/02/21.
//  Copyright © 2021 Sapna Bansal. All rights reserved.
//

import UIKit

class BookMarkViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var LblNavTitle: UILabel!
    @IBOutlet weak var BtnBack: UIButton!
   
    
//    var detailResponse:NewsDataModel? = nil
//     var detailViewmodel = DetailViewModel()
    var catagaryArraya = [Article]()

    var currentIndex = 0
    
    override func viewDidLoad() {
       super.viewDidLoad()
        detailTableView.register(UINib(nibName: "PopularNewsTVC", bundle: nil), forCellReuseIdentifier: "PopularNewsTVC")
        self.catagaryArraya = delegate?.bookmarkArrayList ?? []
        self.detailTableView.delegate = self
        self.detailTableView.dataSource = self
        self.detailTableView.reloadData()
        detailTableView.tableFooterView = UIView()
       
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func searchAction(_ sender: Any) {
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       if catagaryArraya.count == 0 {
              self.detailTableView.setEmptyMessage("No data found")
          } else {
              self.detailTableView.restore()
          }
        return catagaryArraya.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "PopularNewsTVC") as? PopularNewsTVC else { return UITableViewCell() }
        let modelObj = catagaryArraya[indexPath.row]
            cell.LblTitle.text = modelObj.title
            cell.LBLDes.text = modelObj.articleDescription
            cell.ImgThumbNail.backgroundColor = .black
            cell.LblSource.text = modelObj.source?.name
        cell.BtnBookMark.tag = indexPath.row
        cell.BtnBookMark.setImage(#imageLiteral(resourceName: "selected_BookMark"), for: .normal)
        cell.BtnBookMark.addTarget(self, action: #selector(addBookMark(_:)), for: .touchUpInside)
        cell.ImgThumbNail.setImage(image: modelObj.urlToImage ?? "")
        return cell
    }
    @objc func addBookMark(_ sender:UIButton){
        delegate?.bookmarkArrayList.remove(at: sender.tag)
         self.catagaryArraya = delegate?.bookmarkArrayList ?? []
        detailTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
}
extension UITableView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
