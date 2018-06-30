//
//  MathController.swift
//  ColorMatch
//
//  Created by Yerkegali Abubakirov on 29.06.2018.
//  Copyright © 2018 Yerkegali Abubakirov. All rights reserved.
//

import UIKit

class MathController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var firstBtn: UIButton!
    @IBOutlet weak var secondBtn: UIButton!
    @IBOutlet weak var thirdBtn: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    var tag = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playButton.isUserInteractionEnabled = false

    }
    @IBAction func firstBtn(_ sender: UIButton) {
        self.tag = 1
        firstBtn.backgroundColor = UIColor.magenta
        secondBtn.backgroundColor = UIColor.blue
        thirdBtn.backgroundColor = UIColor.blue
        playButton.isUserInteractionEnabled = true
        
    }
    @IBAction func secondBtn(_ sender: UIButton) {
        self.tag = 2
        firstBtn.backgroundColor = UIColor.blue
        secondBtn.backgroundColor = UIColor.magenta
        thirdBtn.backgroundColor = UIColor.blue
        playButton.isUserInteractionEnabled = true
    }
    @IBAction func thirdBtn(_ sender: UIButton) {
        tag = 3

        firstBtn.backgroundColor = UIColor.blue
        secondBtn.backgroundColor = UIColor.blue
        thirdBtn.backgroundColor = UIColor.magenta
        playButton.isUserInteractionEnabled = true
    }
    
    
    
    @IBAction func playButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toGameVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.destination.isKind(of: GameController.self)){
            let gameVC = segue.destination as! GameController
            gameVC.delegate = self
        }
    }
    
}

extension MathController: GameControllerDelegate {
    
    func gameScore(score: Int, name: String) {
        self.nameLabel.text = name
        self.scoreLabel.text = String(score)
    }
    
}
