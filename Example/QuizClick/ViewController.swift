//
//  ViewController.swift
//  QuizClick
//
//  Created by jongwan on 11/21/2023.
//  Copyright (c) 2023 jongwan. All rights reserved.
//

import UIKit
import QuizClick

class ViewController: UIViewController {
    @IBOutlet var buttonV2: UIButton!
    @IBOutlet var buttonV1: UIButton!
    @IBOutlet var adId: UITextField!
    
    @IBOutlet var userId: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        
        buttonV1.addTarget(self, action: #selector(openQuiz) , for: .touchUpInside)
        
        buttonV2.addTarget(self, action: #selector(openQuizV2) , for: .touchUpInside)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func openQuiz(){
        let quiz = QuizClickLoader(ukey: userId.text!, ad_group: adId.text!, version: 1)
        self.present(quiz.load(), animated: true)
        //self.navigationController?.pushViewController(quiz.load(), animated: true)
    }
    
    @objc private func openQuizV2(){
        
        let quiz = QuizClickLoader(ukey: userId.text!, ad_group: adId.text!, version: 2)
        self.present(quiz.load(), animated: true)
        //self.navigationController?.pushViewController(quiz.loadPrepare(), animated: true)
    }

}

