//
//  RegisterViewController.swift
//  Flash-Chat-App
//
//  Created by Evgeniy Zelinskiy on 25.01.2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var registerHintLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        emailTextfield.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        passwordTextfield.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let authError = error {
                    self.registerHintLabel.isHidden = false
                    self.registerHintLabel.text = authError.localizedDescription
                } else {
                    self.performSegue(withIdentifier: K.registerSegue, sender: self)
                }
            }
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.registerHintLabel.isHidden = true
    }
}
