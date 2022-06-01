//
//  ViewController.swift
//  fourthproject
//
//  Created by begaiym akunova on 12/4/22.
//

import UIKit
import WebKit

class ViewController: UITableViewController, WKNavigationDelegate {
    var websites = ["apple.com","hackingwithswift.com","waitbutwhy.com"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "List of Sites"

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Site" , for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.websites = websites
            if websites[indexPath.row] == "apple.com" {
                let alert = UIAlertController(title: "Blocked website", message: "You are not allowed to access website", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                present(alert, animated: true)
            } else {
            vc.currentWebsite = websites[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }


}

