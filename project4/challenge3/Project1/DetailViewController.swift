//
//  DetailViewController.swift
//  Project1
//
//  Created by Derek McLean on 08/03/2019.
//  Copyright © 2019 McLean Digital Limited. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var selectedSite: String!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = selectedSite
        let url = URL(string: selectedSite!)!
        
        navigationItem.largeTitleDisplayMode = .never
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        print("success?")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

}
