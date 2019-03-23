//
//  ViewController.swift
//  Project 4
//
//  Created by Derek Stephen McLean on 23/03/2019.
//  Copyright © 2019 Derek Stephen McLean. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        let url = URL(string: "https://wingsoverscotland.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }

    @objc func openTapped() {
        let ac = UIAlertController(title: "Open page…", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "independencelive.net", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "indylive.radio", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "randompublicjournal.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "thoughtcontrolscotland.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "wingsoverscotland.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    func openPage(action: UIAlertAction) {
        guard let actionTitle = action.title else {return}
        guard let url = URL(string: "https://" + actionTitle) else {return}
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
}

