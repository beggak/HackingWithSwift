//
//  ViewController.swift
//  firstproject
//
//  Created by begaiym akunova on 23/3/22.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Recommend", style: .plain, target: self, action: #selector(recommend))

        performSelector(inBackground: #selector(loadPicturesOnABackground), with: nil)
        
        tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
    }
    
    
    @objc func loadPicturesOnABackground() {
        let fm =  FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        //let sortedPictures = pictures.sort()
        
        tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        //tableView.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        let picture = pictures[indexPath.row]
        cell.textLabel?.text = picture
//        if let shownedTimes = defaults.object(forKey: picture) as? Int {
//            cell.detailTextLabel?.text = "Showned \(shownedTimes) times"
//            defaults.set(shownedTimes, forKey: picture)
//        }
        let shownedTimes = defaults.integer(forKey: picture)
        cell.detailTextLabel?.text = "Showned \(shownedTimes) times"
        defaults.set(shownedTimes, forKey: picture)
        
        
        return cell
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            
            vc.numberOfImage = indexPath.row + 1
            vc.totalPictures = pictures.count
            let picture = pictures[indexPath.row]

            if let currentCount = defaults.object(forKey: picture) as? Int {
                defaults.set(currentCount + 1, forKey: picture)
            } else {
                defaults.set(1, forKey: picture)
            }
            
        
        navigationController?.pushViewController(vc, animated: true)
        tableView.reloadData()
        }
    }
    
    @objc func recommend() {
        let text = "Download this app!"
        
        let vc = UIActivityViewController(activityItems: [text], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        vc.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook]
        present(vc, animated: true)
    }
    // ------------------------------------------------------------------------------------------- //
//    func save() {
//        let jsonEncoder = JSONEncoder()
//        if let savedData = try? jsonEncoder.encode(count),
//            let savedPictures = try? jsonEncoder.encode(pictures) {
//            let defaults = UserDefaults.standard
//            defaults.set(savedData, forKey: "count")
//            defaults.set(savedPictures, forKey: "pictures")
//        } else {
//            print("Failed to load data")
//        }
//    }


}

