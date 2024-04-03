//
//  WebViewController.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 19/3/2024.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var urltring: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: urltring) else { return }
        
        webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        view.addSubview(webView)
        
        // Constraints for web view
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // Load URL
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

