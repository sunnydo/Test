//
//  SpeedTestViewController.swift
//  SpeedTest
//
//  Created by Sunny Do on 18/01/2018.
//  Copyright © 2018 Sunny Do. All rights reserved.
//

import UIKit
import ImageSlideshow


class SpeedTestViewController: UIViewController,UITableViewDataSource {
//outlet
    @IBOutlet weak var loadingView: SpringView!
    @IBOutlet weak var slideshowView: ImageSlideshow!
    @IBOutlet weak var tableView: UITableView!
    
    //local properties
    var dataSpeeds = [Speed]();
    var firstTime = true;
    private let refreshControl = UIRefreshControl()
    
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        loadingView.showLoading()
        setUpSlideshow()
        setupSpeedTest()
        configPullToRefesh()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if (!firstTime) {
            loadingView.showLoading()
            setUpSlideshow()
            setupSpeedTest()
        }
        if(firstTime) {
            firstTime = false;
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - slideshow
    func setUpSlideshow() {
        slideshowView.backgroundColor = UIColor.black
        slideshowView.slideshowInterval = 5.0
        slideshowView.pageControlPosition = PageControlPosition.underScrollView
        slideshowView.pageControl.currentPageIndicatorTintColor = UIColor.white
        slideshowView.pageControl.pageIndicatorTintColor = UIColor.lightGray
        slideshowView.contentScaleMode = UIViewContentMode.scaleAspectFill
        
        // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
        slideshowView.activityIndicator = DefaultActivityIndicator()
        slideshowView.currentPageChanged = { page in
            print("current page:", page)
        }
        
        getImagesForShowing { (slides) in
            self.slideshowView.setImageInputs(slides)
        }
    }
    func getImagesForShowing(completion:@escaping (_ slides:[AlamofireSource]) -> Void) {
        ServerAPI.shared.getSlideAPI { (slides) in
            completion( slides)
        }
    }
    
    //MARK: - get test speed data
    func setupSpeedTest () {
        ServerAPI.shared.getSpeedAPI { (speedResults) in
            self.dataSpeeds = speedResults
            DispatchQueue.main.async { [unowned self] in
                self.tableView.reloadData()
                self.loadingView.hideLoading()
                self.refreshControl.endRefreshing()
                self.sendPing()
            }
        }
    }
    var ss = [SimplePingClient]()
    func sendPing () {
        ss.removeAll()
        for i in dataSpeeds {
            let s = SimplePingClient()
            ss.append(s)
            s.pingHostname(hostname: i.domainString!, andResultCallback: { (str) in
                NSLog("______\(i.domainString!) is \(str!) ms")
            })
        }
        //ss.removeAll()
    }
    
    //MARK: - table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSpeeds.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpeedCell", for: indexPath) as! SpeedTestTableViewCell
        cell.speedInfo = dataSpeeds[indexPath.row];
        return cell;
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
        setupSpeedTest()
    }

}
