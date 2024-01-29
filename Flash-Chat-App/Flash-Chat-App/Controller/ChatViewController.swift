//
//  ViewController.swift
//  Flash-Chat-App
//
//  Created by Evgeniy Zelinskiy on 25.01.2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    var db = Firestore.firestore()
    
    var messages: [MessageModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "⚡️FlashChat"
        navigationItem.hidesBackButton = true
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessagesFromDb()
    }
    
    func loadMessagesFromDb() {
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { querySnapshot, error in
            if let getDocumentsError = error {
                print(getDocumentsError.localizedDescription)
            } else {
                self.messages = []
                if let snapshotDocuments = querySnapshot?.documents {
                    for document in snapshotDocuments {
                        let data = document.data()
                        if let sender = data[K.FStore.senderField] as? String, let body = data[K.FStore.bodyField] as? String {
                            self.messages.append(MessageModel(sender: sender, body: body))
                        }
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        if self.messages.count > 0 {
                            let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                            self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: messageSender,
                K.FStore.bodyField: messageBody,
                K.FStore.dateField: Date().timeIntervalSince1970
            ]) { error in
                if let addDocumentError = error {
                    print(addDocumentError.localizedDescription)
                } else {
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                    }
                    print("Message added to db")
                }
            }
        }
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

//MARK: - UITableViewDataSource

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        let messageModel = messages[indexPath.row]
        if let userEmail = Auth.auth().currentUser?.email {
            cell.isMyMessage = userEmail == messageModel.sender ? true : false
        }
        cell.messageBody.text = messageModel.body
        return cell
    }
}

//MARK: - UITableViewDelegate

extension ChatViewController: UITableViewDelegate {
    
}
