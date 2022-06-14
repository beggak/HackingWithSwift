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
        
        title = "Countries I want to visit"
        
        guard let urlPath = Bundle.main.path(forResource: "json-countries", ofType: "json") else { return }
        let url = URL(fileURLWithPath: urlPath)
        if let data = try? Data(contentsOf: url) {
            parse(json: data)
            return
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
        let country = countries[indexPath.row]
        cell.textLabel?.text = country.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = countries[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

}

