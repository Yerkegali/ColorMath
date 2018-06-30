//
//  ViewController.swift
//  ColorMatch
//
//  Created by Yerkegali Abubakirov on 29.06.2018.
//  Copyright © 2018 Yerkegali Abubakirov. All rights reserved.
//

import UIKit

class ColorController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var colorName: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var trueButton: UIButton!
    
    let colors = [UIColor.black, UIColor.blue, UIColor.brown, UIColor.cyan, UIColor.gray, UIColor.green, UIColor.orange, UIColor.yellow]
    
    let colorsNames = ["BLACK", "BLUE", "BROWN", "CYAN", "GRAY", "GREEN", "ORANGE", "YELLOW"]
    
    var colorIndex = 0
    var colorNameIndex = 0
    var score = 0
    
    func setupViews() {
        colorIndex = Int(arc4random_uniform(UInt32(colors.count)))
        colorNameIndex = Int(arc4random_uniform(UInt32(colors.count)))
        
        colorName.text = colorsNames[colorNameIndex]
        mainView.backgroundColor = colors[colorIndex]
    }
    
    func gameOver() {
        
            falseButton.isUserInteractionEnabled = false
            trueButton.isUserInteractionEnabled = false
            
        let alert = UIAlertController(title: "GameOver", message: "Your score is \(scoreLabel.text!)" , preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
            self.falseButton.isUserInteractionEnabled = true
            self.trueButton.isUserInteractionEnabled = true
        }))
        
        present(alert, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.layer.cornerRadius = 10
        trueButton.layer.cornerRadius = 10
        falseButton.layer.cornerRadius = 10
        
        
    }
    
    @IBAction func falseButton(_ sender: UIButton) {
        
        if colorNameIndex != colorIndex {
                score += 1
                scoreLabel.text = String(score)
        }
        else {
                score -= 1
                scoreLabel.text = String(score)
            if score == 0 || score < 0 {
                scoreLabel.text = "0"
                gameOver()
            }
        }
        
        setupViews()
    }
    
    @IBAction func trueButton(_ sender: UIButton) {
        
        if colorNameIndex == colorIndex {
            score += 1
            scoreLabel.text = String(score)
        }
        else {
            score -= 1
            scoreLabel.text = String(score)
            if score == 0 || score < 0 {
                scoreLabel.text = "0"
                gameOver()
            }
        }
        setupViews()
    }
    
}

