//
//  ViewController.swift
//  GuessWho
//
//  Created by Daehoon Lee on 2023/10/05.
//

import UIKit

class ViewController: UIViewController {
    private let mainView = MainView()
    private let categoryView = CategoryView()
    private let quizView = QuizView()

    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configureAction() {
        
    }
}

