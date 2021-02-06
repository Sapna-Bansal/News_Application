//
//  ViewController.swift
//  NewsApp
//
//  Created by Sapna Bansal on 06/02/21.
//  Copyright © 2021 Sapna Bansal. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
     var newsDataViewmodel = NewsDataViewModel()
     var refreshControl = UIRefreshControl()
     var currentPage = 1
     var totalPage = 2

    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // set up activity indicator
        activityIndicator.center = CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2)
        activityIndicator.color = UIColor.black
        self.view.addSubview(activityIndicator)

        newsDataViewmodel.controler = self
        self.tableView.estimatedRowHeight = 130.0
        self.tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "TopNewsCellTVC", bundle: nil), forCellReuseIdentifier: "TopNewsCellTVC")
        tableView.register(UINib(nibName: "PopularNewsTVC", bundle: nil), forCellReuseIdentifier: "PopularNewsTVC")
        activityIndicator.startAnimating()
        fetchNewData()
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        if currentPage > totalPage{
            return
        }
        if currentPage < totalPage{
            currentPage += 1

            if ((self.newsDataViewmodel.response?.articles!.count)!)>0{
                for n in ((self.newsDataViewmodel.response?.articles!.count)!/2)...(((self.newsDataViewmodel.response?.articles!.count)!-1)) {
                   print(n)
                self.newsDataViewmodel.catagaryArray.append(self.newsDataViewmodel.response!.articles![n])
               }
                self.tableView.reloadData()

            }
        }
    }

//MARK:-  API call
    @objc func fetchNewData(){
        ApiClient.loder(roughter: APIRouter.responce) { (DataResopnce:NewsDataModel) in
            self.activityIndicator.stopAnimating()

            self.newsDataViewmodel.response = DataResopnce
            if self.newsDataViewmodel.currentPage == 1{
                if (DataResopnce.articles?.count ?? 0)>0{
                for n in 0...((self.newsDataViewmodel.response?.articles!.count)!/2-1) {
                    print(n)
                    self.newsDataViewmodel.catagaryArray.append(DataResopnce.articles![n])
                }
             }
            }else{
                if (DataResopnce.articles?.count ?? 9)>0{
                    for n in 10...(DataResopnce.articles?.count)! {
                       print(n)
                       self.newsDataViewmodel.catagaryArray.append(DataResopnce.articles![n])
                   }
                    self.refreshControl.endRefreshing()

                }
            }
//            self.newsDataViewmodel.catagaryArray = DataResopnce.articles ?? []
          
            self.tableView.delegate = self.newsDataViewmodel
            self.tableView.dataSource = self.newsDataViewmodel
            self.tableView.reloadData()
            
            print("DataResopnceagsdfjhagdjda\(DataResopnce)")
        }
        
    }
    @IBAction func bookMarkAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let subCategoryController = storyboard.instantiateViewController(withIdentifier: "BookMarkViewController") as! BookMarkViewController
        self.navigationController?.pushViewController(subCategoryController, animated: true)
    }
    
    @IBAction func searchAction(_ sender: UIButton) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let subCategoryController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
//        self.navigationController?.pushViewController(subCategoryController, animated: true)
    }
}
