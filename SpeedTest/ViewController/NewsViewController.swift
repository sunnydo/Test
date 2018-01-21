//
//  NewsViewController.swift
//  SpeedTest
//
//  Created by Sunny Do on 18/01/2018.
//  Copyright © 2018 Sunny Do. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //outlet
    @IBOutlet weak var loadingView: SpringView!
    @IBOutlet weak var tableView: UITableView!
    
    //properties
    var dataNews:[News] = []
    var firstTime = true;
    private let refreshControl = UIRefreshControl()
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        self.loadingView.showLoading()
        setUpNews()
        configPullToRefesh()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if (!firstTime) {
            self.loadingView.showLoading()
            setUpNews()
        }
        if(firstTime) {
            firstTime = false;
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - get news
    
    func setUpNews () {
        ServerAPI.shared.getNewsAPI { (news) in
            self.dataNews = news
            DispatchQueue.main.async { [unowned self] in
                self.tableView.reloadData()
                self.loadingView.hideLoading()
                self.refreshControl.endRefreshing()
            }
        }
    }
    // MARK: - Pull to refresh
    func configPullToRefesh(){
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "加载中 ...",attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 216.0/255.0, green: 211.0/255.0, blue: 235.0/255.0, alpha: 1.0)])
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refresh(refreshControl:)), for: .valueChanged)
        self.tableView.addSubview(refreshControl)
    }
    @objc func refresh(refreshControl:UIRefreshControl) {
        setUpNews()
    }
    
    //MARK: - table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataNews.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsTableViewCell
        cell.news = dataNews[indexPath.row];
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //init Detail view
        let nextView = storybroad.instantiateViewController(withIdentifier: "NewsDetailViewController") as! NewsDetailViewController
        //set info
        nextView.imageURL = dataNews[indexPath.row].contentURLString
        //push
        self.navigationController?.pushViewController(nextView, animated: true)
        
        }
    
    
}
