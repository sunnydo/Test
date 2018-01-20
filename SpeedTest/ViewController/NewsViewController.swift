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
    @IBOutlet weak var tableView: UITableView!
    
    //properties
    var dataNews:[News] = []
    var firstTime = true;
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNews()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if (!firstTime) {
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
            }
        }
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
        self.navigationController!.pushViewController(nextView, animated: true)
        
            }
    
    
}
