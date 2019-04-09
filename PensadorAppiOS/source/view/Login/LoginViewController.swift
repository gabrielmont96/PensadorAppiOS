//
//  LoginViewController.swift
//  PensadorAppiOS
//
//  Created by stag on 08/04/19.
//  Copyright © 2019 Gabriel Silva. All rights reserved.
//

import UIKit
import FirebaseAuth
import TextFieldEffects

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: TextFieldEffects?
    @IBOutlet weak var passwordTextField: TextFieldEffects?
    @IBOutlet weak var signButton: UIButton?
    @IBOutlet weak var registerButton: UIButton?
    @IBOutlet weak var rememberImage: UIImageView?
    @IBOutlet var messageErrorLabel: Array<UILabel> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(dismissKeyboard())
    }
    
    @objc func remember(_ sender:UITapGestureRecognizer) {

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        configTextField()
        
        if UserDefaults.standard.bool(forKey: "remember") {
            if usernameTextField?.text != "" && passwordTextField?.text != "" {
                rememberImage?.image = UIImage(named: "rememberchecked")
            }
        } else {
            rememberImage?.image = UIImage(named: "rememberunchecked")
        }
        
        if let username = UserDefaults.standard.string(forKey: "username"), let password = UserDefaults.standard.string(forKey: "password") {
            usernameTextField?.text = username
            passwordTextField?.text = password
        } else {
            usernameTextField?.text = ""
            passwordTextField?.text = ""
        }
    }
    
    func configTextField() {
        usernameTextField?.borderStyle = .none
        usernameTextField?.placeholder = "Email"
        
        passwordTextField?.borderStyle = .none
        passwordTextField?.placeholder = "Password"
        
    }
    
    
    
    @IBAction func rememberButtonTapped(_ sender: Any) {
        if UserDefaults.standard.bool(forKey: "remember") {
            UserDefaults.standard.set(false, forKey: "remember")
            rememberImage?.image = UIImage(named: "rememberunchecked")
            print("ta false")
        } else {
            rememberImage?.image = UIImage(named: "rememberchecked")
            UserDefaults.standard.set(true, forKey: "remember")
            print("ta true")
        }
    }
    
    @IBAction func signButtonTapped(_ sender: Any) {
        guard let username = usernameTextField?.text else {
            return
        }
        guard let password = passwordTextField?.text else {
            return
        }
        
        if username.isEmpty && password.isEmpty {
            for i in 0...1 {
                messageErrorLabel[i].isHidden = false
            }
            return
        } else if username.isEmpty {
            messageErrorLabel[0].isHidden = false
            messageErrorLabel[1].isHidden = true
            return
        } else if password.isEmpty {
            messageErrorLabel[1].isHidden = false
            messageErrorLabel[0].isHidden = true
            return
        }
        
        for i in 0...1 {
            messageErrorLabel[i].isHidden = true
        }
        
        
//        errorLabel?.text = ""
        Auth.auth().signIn(withEmail: username, password: password, completion: { (user, error) in
            if let u = user {
                if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as? MainViewController {
//                    self.navigationController?.present(vc, animated: true, completion: nil)
                    self.messageErrorLabel[2].isHidden = true
                    self.navigationController?.isNavigationBarHidden = false
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                    if UserDefaults.standard.bool(forKey: "remember") {
                        UserDefaults.standard.set(username, forKey: "username")
                        UserDefaults.standard.set(password, forKey: "password")
                    } else {
                        UserDefaults.standard.removeObject(forKey: "username")
                        UserDefaults.standard.removeObject(forKey: "password")
                    }

                    
                }
            } else {
                self.messageErrorLabel[2].isHidden = false
                print("erro login")
            }
        })
        
        
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        guard let username = usernameTextField?.text else { return }
        guard let password = passwordTextField?.text else { return }
        
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController {
            self.addChild(vc)
            vc.emailPrevious = username
            vc.passwordPrevious = password
            self.view.addSubview(vc.view)
            vc.didMove(toParent: self)
        }
    }
    
}
