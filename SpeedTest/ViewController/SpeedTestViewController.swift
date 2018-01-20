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
    @IBOutlet weak var slideshowView: ImageSlideshow!
    @IBOutlet weak var tableView: UITableView!
    
    //local properties
    var dataSpeeds = [Speed]();
    var firstTime = true;
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSlideshow()
        setupSpeedTest()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if (!firstTime) {
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
        slideshowView.backgroundColor = UIColor.white
        slideshowView.slideshowInterval = 5.0
        slideshowView.pageControlPosition = PageControlPosition.underScrollView
        slideshowView.pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        slideshowView.pageControl.pageIndicatorTintColor = UIColor.black
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
            }
        }
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
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: Selector(("refresh:")), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(refreshControl)
    }
    func refresh(refreshControl:UIRefreshControl) {
        setupSpeedTest()
    }

}
