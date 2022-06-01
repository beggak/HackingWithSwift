//
//  ViewController.swift
//  MilestoneOfProjects46
//
//  Created by begaiym akunova on 18/4/22.
//

import UIKit

class ViewController: UITableViewController {
    var list = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
            
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(enterList))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(resetAll))
        
        let share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share))
        
        navigationItem.rightBarButtonItems = [add, share]
        

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word",for: indexPath)
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
    
    @objc func enterList() {
        let ac = UIAlertController(title: "What are you going to buy?", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        ac.addAction(addAction)
        present(ac, animated: true)
    }
    
    @objc func resetAll() {
        list.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func share() {
        if !list.isEmpty {
            let stringList = list.joined(separator: "\n")
            let vc = UIActivityViewController(activityItems: [stringList], applicationActivities: [])
            vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
            present(vc,animated: true)
        } else {
            let ac = UIAlertController(title: "There is no any list", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    func submit(_ answer: String) {
        
        let lowerAnswer = answer.lowercased()
        
        var errorTitle: String
        var errorMessage: String
        
        if isReal(word: lowerAnswer){
            if isOriginal(word: lowerAnswer) {
        
        list.insert(lowerAnswer, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        return
                
            } else {
               errorTitle = "You added this one to our list!"
               errorMessage = "Choose another one"
               showErrorMessage(title: errorTitle, message: errorMessage)
            }
        } else {
            errorTitle = "The word is not recognized!"
            errorMessage = "Be more correct"
            showErrorMessage(title: errorTitle, message: errorMessage)
        }
    }
    
    func isReal(word: String) -> Bool {
        
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        if misspelledRange.location == NSNotFound {
            return true
        } else {
            return false
        }

    }
    
    func isOriginal(word: String) -> Bool {
        
        return !list.contains(word)

    }
    
    func showErrorMessage(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }


}

