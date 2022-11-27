//
//  ChatViewController.swift
//  NaNoChat
//
//  Created by Şeyda Soylu on 7.11.2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class ChatViewController: UIViewController, UIScrollViewDelegate ,UITextFieldDelegate {
    
    @IBOutlet var senderButtonOutlet: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    let db = Firestore.firestore()
    var messages: [Message] = [
        Message(sender: "1@2.com", body: "Selam"),
        Message(sender: "1@2.com", body: "Selam")
    ]
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.scrollEdgeAppearance = UINavigationBarAppearance()
        tableView.dataSource = self
        title = sabitler.appName
        navigationItem.hidesBackButton = true
        tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        self.hideKeyboardWhenTappedAround()
        loadMessage()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        textField.delegate = self
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let body = textField.text ,  let sender = Auth.auth().currentUser?.email , body != "" {
            db.collection(sabitler.collectionName).addDocument(data: [
                sabitler.senderfield :sender  ,
                sabitler.bodyfield : body,
                sabitler.datefield : Date().timeIntervalSince1970
            ]) { err in
                if let e = err {
                    print(e)
                } else {
                    print("Succesfully")
                }
            }
        }
        textField.text = ""
        return true
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    func delete() {
        
    }
    @IBAction func logOutButton(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
    }
    @IBAction func senderButton(_ sender: UIButton) {
        if let body = textField.text ,  let sender = Auth.auth().currentUser?.email , body != "" {
            db.collection(sabitler.collectionName).addDocument(data: [
                sabitler.senderfield :sender  ,
                sabitler.bodyfield : body,
                sabitler.datefield : Date().timeIntervalSince1970
            ]) { err in
                if let e = err {
                    print(e)
                } else {
                    print("Succesfully")
                }
            }
        }
        textField.text = ""
    }
    func loadMessage(){
        db.collection(sabitler.collectionName).order(by: sabitler.datefield).addSnapshotListener() { (querySnapshot, err) in
            self.messages = []
            if let e = err {
                print(e)
            } else {
                for doc in querySnapshot!.documents {
                    let data = doc.data()
                    if let messagebody = data[sabitler.bodyfield] , let messagesender = data[sabitler.senderfield] {
                        let newMessage = Message(sender: messagesender as! String, body: messagebody as! String)
                        self.messages.append(newMessage)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            let indexpath = IndexPath(row: self.messages.count - 1, section: 0)
                            self.tableView.scrollToRow(at: indexpath, at: .top, animated: false)
                            
                        }
                    }
                }
            }
        }
    }
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        tableView.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: sabitler.recell , for: indexPath) as! MessageCell
        cell.label.text = message.body
        
        if message.sender == Auth.auth().currentUser?.email {
            cell.rightİmageView.isHidden = false
            cell.leftİmageView.isHidden = true
        } else {
            cell.rightİmageView.isHidden = true
            cell.leftİmageView.isHidden = false
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
}


