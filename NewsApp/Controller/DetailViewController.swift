//
//  DetailViewController.swift
//  NewsApp
//
//  Created by Sapna Bansal on 06/02/21.
//  Copyright © 2021 Sapna Bansal. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var LblNavTitle: UILabel!
    @IBOutlet weak var BtnBack: UIButton!
//    @IBOutlet weak var ImgThumbNail: UIImageView!
//    @IBOutlet weak var LblTitle: UILabel!
//    @IBOutlet weak var LBLDes: UILabel!
//    @IBOutlet weak var ViewSourceVw: UIView!
//    @IBOutlet weak var LblSource: UILabel!
    
    var detailResponse:NewsDataModel? = nil
     var detailViewmodel = DetailViewModel()
    var currentIndex = 0
    override func viewDidLoad() {
       super.viewDidLoad()
        detailTableView.register(UINib(nibName: "DetailTVC", bundle: nil), forCellReuseIdentifier: "DetailTVC")
        detailTableView.register(UINib(nibName: "PopularNewsTVC", bundle: nil), forCellReuseIdentifier: "PopularNewsTVC")
        loadDetailData()
        self.detailViewmodel.catagaryArraya = detailResponse?.articles ?? []
       
        self.detailTableView.estimatedRowHeight = 130.0
        self.detailTableView.rowHeight = UITableView.automaticDimension
   
        self.detailTableView.delegate = self
        self.detailTableView.dataSource = self
        self.detailTableView.reloadData()
        detailTableView.layoutIfNeeded()
        guard #available(iOS 10.0, *) else {
                   // Manually observe the UIContentSizeCategoryDidChange
                   // notification for iOS 9.
                   NotificationCenter.default.addObserver(self, selector: #selector(contentSizeDidChange(_:)), name: UIContentSizeCategory.didChangeNotification, object: nil)
                   return
               }
        
        viewDidLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
//         NotificationCenter.default.addObserver(self, selector: #selector(onReceiveData(_:)), name: NSNotification.Name(rawValue: "ReceiveData"), object: nil)
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func loadDetailData()  {
        let modelObj = detailResponse?.articles?[currentIndex+1]
        LblNavTitle.text = modelObj?.urlToImage
    }
    @objc private func contentSizeDidChange(_ notification: NSNotification) {
        detailTableView.reloadData()
    }

    @objc func onReceiveData(_ notification:Notification)  {
        detailTableView.reloadData()
    }
    var sectionData = ["","Popular News"]
    func numberOfSections(in tableView: UITableView) -> Int{
        return sectionData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0) ? 1 : detailResponse!.articles!.count-1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionData[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if(indexPath.section == 0){
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTVC") as? DetailTVC else { return UITableViewCell() }
          let modelObj = detailResponse?.articles?[currentIndex]
           cell.LblTitle.text = modelObj?.title
           cell.LBLDes.text = modelObj?.articleDescription
           cell.ImgThumbNail.backgroundColor = .black
           cell.LblSource.text = modelObj?.source?.name
           cell.ImgThumbNail.setImage(image: modelObj?.urlToImage ?? "")
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PopularNewsTVC") as? PopularNewsTVC else { return UITableViewCell() }
        let modelObj = detailResponse?.articles?[indexPath.row+1]
            cell.LblTitle.text = modelObj?.title
            cell.LBLDes.text = modelObj?.articleDescription
            cell.ImgThumbNail.backgroundColor = .black
            cell.LblSource.text = modelObj?.source?.name
            cell.ImgThumbNail.setImage(image: modelObj?.urlToImage ?? "")
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()

            guard let headerView = detailTableView.tableHeaderView else {return}
            let size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
            if headerView.frame.size.height != size.height {
                headerView.frame.size.height = size.height
                detailTableView.tableHeaderView = headerView
                detailTableView.layoutIfNeeded()
                 detailTableView.reloadData()
            }
        }
    
}
