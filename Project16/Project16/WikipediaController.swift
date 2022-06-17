//
//  WikipediaController.swift
//  Project16
//
//  Created by begaiym akunova on 18/6/22.
//

import UIKit
import WebKit

class WikipediaController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var urlString: String?
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let urlString = urlString {
            let url = URL(string: "https://en.wikipedia.org/wiki/\(urlString)")!
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
            
        }

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
