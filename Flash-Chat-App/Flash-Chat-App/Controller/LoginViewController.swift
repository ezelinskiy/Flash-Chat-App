//
//  LoginViewController.swift
//  Flash-Chat-App
//
//  Created by Evgeniy Zelinskiy on 25.01.2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var loginHintLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextfield.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        passwordTextfield.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }

    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let authError = error {
                    self.loginHintLabel.isHidden = false
                    self.loginHintLabel.text = authError.localizedDescription
                } else {
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                }
            }
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.loginHintLabel.isHidden = true
    }
}
