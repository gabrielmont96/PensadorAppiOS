//
//  RegisterViewController.swift
//  PensadorAppiOS
//
//  Created by stag on 08/04/19.
//  Copyright © 2019 Gabriel Silva. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField?
    @IBOutlet weak var passwordTextField: UITextField?
    @IBOutlet weak var screenRegisterView: UIView?
    @IBOutlet weak var ageTextField: UITextField?
    
    var emailPrevious = ""
    var passwordPrevious = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.isOpaque = false

        self.view.addGestureRecognizer(dismissKeyboard())
        self.view.backgroundColor = UIColor.clear.withAlphaComponent(0.8)

        emailTextField?.text = emailPrevious
        passwordTextField?.text = passwordPrevious
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseIn, animations: {
            self.view.alpha = 1.0
            
        })
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        
        UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseOut, animations: {
            self.view.alpha = 0.0
        }, completion: {(isCompleted) in
            self.view.removeFromSuperview()
        })
            
        
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        guard let username = emailTextField?.text, username != "" else {
            self.showToast(message: "Email field is empty!", mode: .error)
            return
        }
        guard let password = passwordTextField?.text, password != "" else {
            self.showToast(message: "Password field is empty!", mode: .error)
            return
        }
        
        Auth.auth().createUser(withEmail: username, password: password, completion: { (user, error) in
            if let u = user {
                self.showToast(message: "Registered successfully", mode: .success)
                UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseOut, animations: {
                    self.view.alpha = 0.0
                }, completion: {(isCompleted) in
                    self.view.removeFromSuperview()
                })
            } else {
                self.showToast(message: "An error has occurred!", mode: .error)
            }
        })
    }
}
