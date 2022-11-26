//
//  RegisterViewController.swift
//  NaNoChat
//
//  Created by Şeyda Soylu on 7.11.2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class RegisterViewController: UIViewController ,UIScrollViewDelegate , UITextFieldDelegate {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet var registerButtonOutlet: UIButton!
    override func viewDidLoad() {
        registerButtonOutlet.layer.cornerRadius = 18
        registerButtonOutlet.layer.shadowColor = UIColor.black.cgColor
        registerButtonOutlet.layer.shadowOffset = CGSize(width: 5, height: 5)
        registerButtonOutlet.layer.shadowRadius = 10
        registerButtonOutlet.layer.shadowOpacity = 0.3
        self.hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    
    
    @IBAction func registerButton(_ sender: UIButton) {
        
        if emailTextField.text != ""  {
            if let email = emailTextField.text , let password = passwordTextField.text {
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in if let e = error {
                    print(e.localizedDescription)
                    if e.localizedDescription == "The email address is badly formatted." {
                        let alert = UIAlertController(title: "Error", message: "Please enter a valid e-mail."
, preferredStyle: UIAlertController.Style.alert)
                        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
                        alert.addAction(okButton)
                        self.present(alert, animated: true, completion: nil)
                    }
                    if self.passwordTextField.text == "" {
                        let alert = UIAlertController(title: "Error", message: "The password must be 6 characters long or more."
    , preferredStyle: UIAlertController.Style.alert)
                        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
                        alert.addAction(okButton)
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        let alert = UIAlertController(title: "Error", message: "The password must be 6 characters long or more."
    , preferredStyle: UIAlertController.Style.alert)
                        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
                        alert.addAction(okButton)
                        self.present(alert, animated: true, completion: nil)
                    }
                        
                    
                }  else  {
                        self.performSegue(withIdentifier: sabitler.registersegue, sender: self)
                        
                    }
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
                self!.registerButtonOutlet.isSelected = false
                }
            self.registerButtonOutlet.isSelected = true
            self.hideKeyboardWhenTappedAround()
        } else if emailTextField.text == "" {
            let alert = UIAlertController(title: "Error", message: "Please enter your mail.", preferredStyle: UIAlertController.Style.alert)
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
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in if let e = error {
                print(e)     } else {
                    self.performSegue(withIdentifier: sabitler.registersegue, sender: self)
                    
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self!.registerButtonOutlet.isSelected = false
            }
        self.registerButtonOutlet.isSelected = true
        self.hideKeyboardWhenTappedAround()
        return true
    }
    

}
