//
//  WebKitViewController.swift
//  SpeedTest
//
//  Created by Sunny on 3/1/18.
//  Copyright © 2018 Sunny Do. All rights reserved.
//

import UIKit
import WebKit

class WebKitViewController: UIViewController,WKNavigationDelegate, WKUIDelegate {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    @IBOutlet weak var webView: SpringView!
    
    var webkit:WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let webConfiguration = WKWebViewConfiguration()
        webkit = WKWebView(frame: .zero, configuration: webConfiguration)
        webkit.uiDelegate = self
        webkit.navigationDelegate = self
        webView.addSubview(webkit)
        self.loadURl(urlStr: "http://33111.me/")
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        webkit.frame = webView.frame
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadURl (urlStr:String) {
        self.webView .showLoading()
        let url:URL! = URL(string: urlStr)!
        let request:URLRequest = URLRequest(url: url)
        self.webkit.load(request)
        self.webkit.allowsBackForwardNavigationGestures = true
    }
    
    @IBAction func button1Pressed(_ sender: UIButton) {
        button1.backgroundColor = darkPupple;
        button2.backgroundColor = lightPupple;
        button3.backgroundColor = lightPupple;
        self.loadURl(urlStr: "http://33111.me/")
    }
    @IBAction func button2Pressed(_ sender: UIButton) {
        button1.backgroundColor = lightPupple;
        button2.backgroundColor = darkPupple;
        button3.backgroundColor = lightPupple;
        self.loadURl(urlStr: "http://22333.me/")
    }
    @IBAction func button3Pressed(_ sender: UIButton) {
        button1.backgroundColor = lightPupple;
        button2.backgroundColor = lightPupple;
        button3.backgroundColor = darkPupple;
        self.loadURl(urlStr: "http://33222.me/")
    }
    
    
    //delegate
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.webView .hideLoading()
    }
    
}
