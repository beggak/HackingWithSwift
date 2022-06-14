//
//  DetailViewController.swift
//  MilestoneOfProjects13-15
//
//  Created by begaiym akunova on 12/6/22.
//

import UIKit
import WebKit


class DetailViewController: UIViewController {
    var webView: WKWebView!
    var detailItem: Country?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let detailItem = detailItem else { return }
        
        title = detailItem.name
        
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 150%; } </style>
        </head>
        <body>
        \(detailItem.capital)<br>
        \(detailItem.currency)<br>
        \(detailItem.size)<br>
        \(detailItem.population)<br>
        \(detailItem.fact)<br>
        </body>
        </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil)
        
    }

}
