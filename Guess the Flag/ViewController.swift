//
//  ViewController.swift
//  Guess the Flag
//
//  Created by Марк Голубев on 09.12.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var countOfAskedQuestions = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
//        button1.layer.borderWidth = 1
//        button2.layer.borderWidth = 1
//        button3.layer.borderWidth = 3
//
//        button1.layer.borderColor = UIColor.lightGray.cgColor
//        button2.layer.borderColor = UIColor.lightGray.cgColor
//        button3.layer.borderColor = UIColor.lightGray.cgColor
        makeArray()
        askQestion()
    }
    
    func askQestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased() + " - Your score is \(score)"

    }
    
    func makeArray() {
        countries.append("estonia")
        countries.append("france")
        countries.append("germany")
        countries.append("ireland")
        countries.append("italy")
        countries.append("monaco")
        countries.append("nigeria")
        countries.append("poland")
        countries.append("russia")
        countries.append("spain")
        countries.append("uk")
        countries.append("us")
    }

    // MARK: - Create IBAction for button
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            score -= 1
        }
        
        if countOfAskedQuestions == 5 {
            
            // MARK: - UIAlertControler
            
            let ac = UIAlertController(title: title, message: "Game over. Your score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Restart", style: .destructive, handler: askQestion))
            score = 0
            correctAnswer = 0
            countOfAskedQuestions = 0

            present(ac, animated: true)


        }
        
        let ac = UIAlertController(title: title, message: "That's the flag of \(countries[sender.tag].uppercased())", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQestion))

        present(ac, animated: true)
        
        countOfAskedQuestions += 1
    }
    
    @objc func shareTapped() {
        let vc = UIActivityViewController(activityItems: ["Your score is \(score)"], applicationActivities: [])
        vc.title = "Your score is \(score)"
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
        }
}

