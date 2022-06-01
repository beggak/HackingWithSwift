//
//  ViewController.swift
//  secondproject
//
//  Created by begaiym akunova on 28/3/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var askedQuestion = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score", style: .plain, target: self, action: #selector(showScore))
        
        countries += ["estonia","france","germany","ireland","italy","monaco","nigeria","poland","russia","spain","uk","us"]
        
        askQuestion()

    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        
        countries.shuffle()
        
        correctAnswer = Int.random(in: 0...2)
        title = (countries[correctAnswer].uppercased())
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        button2.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        button3.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor

    }
    
    func startNewGame(action: UIAlertAction) {
        score = 0
        askedQuestion = 0
        
        askQuestion()
        
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct!"
            score += 1
            askedQuestion += 1
        } else {
            title = "Wrong! This is the flag of \(countries[correctAnswer].uppercased())!"
            score -= 1
            askedQuestion += 1
        }
                
        if askedQuestion < 10 {
               
           let ac = UIAlertController(title: title, message: nil, preferredStyle: .alert)
           ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
           present(ac, animated: true)
    
        } else {
            
            let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            ac.addAction(UIAlertAction(title: "New game", style: .default, handler: startNewGame))
            present(ac, animated: true)
            
            askedQuestion = 0
        }
        
    }
    
    @objc func showScore() {
        
        let scoreAlert = UIAlertController(title: "Score", message: nil, preferredStyle: .actionSheet)
        scoreAlert.addAction(UIAlertAction(title: "Your current score is \(score)", style: .default, handler: nil))
        present(scoreAlert, animated: true)
        
    }


}

