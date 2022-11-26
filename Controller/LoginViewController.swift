//
//  LoginViewController.swift
//  NaNoChat
//
//  Created by Şeyda Soylu on 7.11.2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class LoginViewController: UIViewController , UIScrollViewDelegate, UITextFieldDelegate {

    @IBOutlet var loginButtonOutlet: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButtonOutlet.layer.cornerRadius = 18
        loginButtonOutlet.layer.shadowColor = UIColor.black.cgColor
        loginButtonOutlet.layer.shadowOffset = CGSize(width: 5, height: 5)
        loginButtonOutlet.layer.shadowRadius = 10
        loginButtonOutlet.layer.shadowOpacity = 0.3
        self.hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        passwordTextField.delegate = self
        emailTextField.delegate = self
        
    }
    

    @IBAction func loginButton(_ sender: UIButton) {
        if emailTextField.text != "" , passwordTextField.text != "" {
            if let email = emailTextField.text , let password = passwordTextField.text {
                Auth.auth().signIn(withEmail: email, password: password) { authResult, error in if let e = error {
                    print(e)
                    
                    if e.localizedDescription == "There is no user record corresponding to this identifier. The user may have been deleted." {
                        let alert = UIAlertController(title: "Error", message: "User Not Found", preferredStyle: UIAlertController.Style.alert)
                        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
                        alert.addAction(okButton)
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        let alert = UIAlertController(title: "Error", message: "Wrong Password", preferredStyle: UIAlertController.Style.alert)
                        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
                        alert.addAction(okButton)
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    
                } else {
                        self.performSegue(withIdentifier: sabitler.loginsegue, sender: self)
                    }
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
                self!.loginButtonOutlet.isSelected = false
                }
            self.loginButtonOutlet.isSelected = true
        } else if emailTextField.text == "" {
            let alert = UIAlertController(title: "Error", message: "Please Enter Your Email", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        } else if passwordTextField.text == "" {
            let alert = UIAlertController(title: "Error", message: "Please Enter Your Password", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height / 2
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let email = emailTextField.text , let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in if let e = error {
                print(e) } else {
                    self.performSegue(withIdentifier: sabitler.loginsegue, sender: self)
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self!.loginButtonOutlet.isSelected = false
            }
        self.loginButtonOutlet.isSelected = true
        print("hit")
        return true
    }
    

}
