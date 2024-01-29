//
//  WelcomeViewController.swift
//  Flash-Chat-App
//
//  Created by Evgeniy Zelinskiy on 25.01.2024.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleLabel.text = "⚡️FlashChat"
    }
    

}
