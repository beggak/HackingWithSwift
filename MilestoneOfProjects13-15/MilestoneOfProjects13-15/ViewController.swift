//
//  ViewController.swift
//  MilestoneOfProjects13-15
//
//  Created by begaiym akunova on 10/6/22.
//

import UIKit

class ViewController: UITableViewController {
    var countries = [Country]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlPath = Bundle.main.url(forResource: "json-countries", withExtension: "json")
        let urlString = urlPath?.path
        if let url = URL(string: urlString!) {
            if let data = try? Data(contentsOf: url) {
                //code here
            }
        }
        
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonCountries = try? decoder.decode(Countries.self, from: json) {
            countries = jsonCountries.results
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "It is a title"
        return cell
    }

}

