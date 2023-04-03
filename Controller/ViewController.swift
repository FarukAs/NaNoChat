//
//  ViewController.swift
//  NaNoChat
//
//  Created by Şeyda Soylu on 7.11.2022.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var loginButtonOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButtonOutlet.layer.cornerRadius = 18
        loginButtonOutlet.layer.shadowColor = UIColor.black.cgColor
        loginButtonOutlet.layer.shadowOffset = CGSize(width: 5, height: 5)
        loginButtonOutlet.layer.shadowRadius = 10
        loginButtonOutlet.layer.shadowOpacity = 0.3
        
        
        registerButton.layer.cornerRadius = 18
        registerButton.layer.shadowColor = UIColor.black.cgColor
        registerButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        registerButton.layer.shadowRadius = 10
        registerButton.layer.shadowOpacity = 0.3
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        
    }
    
}

