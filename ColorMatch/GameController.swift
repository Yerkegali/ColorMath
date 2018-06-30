//
//  GameController.swift
//  ColorMatch
//
//  Created by Yerkegali Abubakirov on 29.06.2018.
//  Copyright © 2018 Yerkegali Abubakirov. All rights reserved.
//

import UIKit

protocol GameControllerDelegate {
    func gameScore(score: Int, name: String)
}

class GameController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var answerTxtField: UITextField!
    
    var x = 0
    var y = 0
    var gameTime = 5
    var score = 0
    var name = "name"
    
    var delegate: GameControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.timerLabel.text = "0:\(gameTime)"
        newQuestion()
        
        _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        _ = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(moveQuestion), userInfo: nil, repeats: true)
        
       
    }
    
    func newQuestion() {
        
        let mathVC = MathController()
        
        if (mathVC.tag == 1) {
            self.x = Int(arc4random_uniform(9)+1)
            self.y = Int(arc4random_uniform(9)+1)
        } else if (mathVC.tag == 2) {
            self.x = Int(arc4random_uniform(90)+10)
            self.y = Int(arc4random_uniform(9)+1)
        } else if (mathVC.tag == 3) {
            self.x = Int(arc4random_uniform(900)+100)
            self.y = Int(arc4random_uniform(9)+1)
        }
        
        self.questionLabel.text = "\(self.x)X\(self.y) = "
        self.questionLabel.center.y = 50

    }
    
    @objc func moveQuestion() {
        if(self.questionLabel.center.y >= self.bottomView.center.y){
            score = score - 2
            scoreLabel.text = String(score)
            newQuestion()
        }
        UIView.animate(withDuration: 0.2) {
            self.questionLabel.center.y += 10
        }
    }
    
    @objc func updateTimer(){
        gameTime = gameTime - 1
        self.timerLabel.text = "0:\(gameTime)"
        
        if (gameTime == 0){
            gameOver()
        }
    }
    
    func gameOver() {

        let alert = UIAlertController(title: "GameOver", message: "Your score is \(score)", preferredStyle: .alert)
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "Your name"
            self.name = alertTextfield.text!
        }
//        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
//            self.dismiss(animated: false, completion: nil)
//        }))
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            guard let name2 = textField?.text else { return }
            self.name = name2
            self.dismiss(animated: false, completion: nil)
        }))
        
        present(alert, animated: true, completion: nil)
        print("ndcijwdncwicniw", name)
        
        self.delegate?.gameScore(score: score, name: name)
        
    }
    
    @IBAction func submitButton(_ sender: UIButton) {
        
        let res = Int(self.answerTxtField.text!)
        
        if(res == x*y) {
            score = score + 1
            scoreLabel.text = String(score)
            newQuestion()
        }
        self.answerTxtField.text = ""
    }
}
