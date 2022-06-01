//
//  ViewController.swift
//  fifthproject
//
//  Created by begaiym akunova on 14/4/22.
//

import UIKit

class ViewController: UITableViewController {
    var allWords = [String]()
    var usedWords = [String]()
    var currentWord: String? //changed
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startGame))
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        
        if let presentWord = defaults.object(forKey: "presentWord") as? String,
           let savedWords = defaults.object(forKey: "savedWords") as? [String] {
            title = presentWord
            currentWord = presentWord
            usedWords = savedWords
        } else {
            startGame()
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word",for: indexPath)
        //usedWords = defaults.object(forKey: "usedWords") as? [String] ?? [String]()
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    @objc func startGame() {
        title = allWords.randomElement()
        currentWord = title
        //defaults.set(title, forKey: "title")
        usedWords.removeAll(keepingCapacity: true)
        save()
        tableView.reloadData()
    }
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    
    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        return true
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        if misspelledRange.location == NSNotFound && word.count >= 3 {
            return true
        } else {
            return false
        }
        
    }
    
    func isTitle(word: String) -> Bool {
        if word.lowercased() == title {
            return false
        } else {
            return true
        }
    }
    
    func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()
        
        var errorTitle: String
        var errorMessage: String
        
        if isTitle(word: lowerAnswer) {
            if isPossible(word: lowerAnswer) {
                if isOriginal(word: lowerAnswer) {
                    if isReal(word: lowerAnswer) {
                        usedWords.insert(lowerAnswer, at: 0)
                        //defaults.set(usedWords, forKey: "usedWords")
                        save()
                        let indexPath = IndexPath(row: 0, section: 0)
                        tableView.insertRows(at: [indexPath], with: .automatic)
                        return
                    } else {
                        
                        errorTitle = "Word not recognised or too short"
                        errorMessage = "You can't just make them up, you know!"
                        showErrorMessage(title: errorTitle, message: errorMessage)
                    }
                } else {
                    errorTitle = "Word used already"
                    errorMessage = "Be more original!"
                    showErrorMessage(title: errorTitle, message: errorMessage)
                }
            } else {
                guard let title = title?.lowercased() else { return }
                errorTitle = "Word not possible"
                errorMessage = "You can't spell that word from \(title)"
                showErrorMessage(title: errorTitle, message: errorMessage)
            }
        } else {
            errorTitle = "It's our title!"
            errorMessage = "You can't input a title word"
            showErrorMessage(title: errorTitle, message: errorMessage)
        }
    }
    
    func showErrorMessage(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func save() {
        defaults.set(currentWord, forKey: "presentWord")
        defaults.set(usedWords, forKey: "savedWords")
    }
    
}

