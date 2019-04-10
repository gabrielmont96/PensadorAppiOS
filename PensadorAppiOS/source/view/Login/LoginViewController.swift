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
import TransitionButton

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: TextFieldEffects?
    @IBOutlet weak var passwordTextField: TextFieldEffects?
    @IBOutlet weak var signButton: TransitionButton?
    @IBOutlet weak var rememberImage: UIImageView?
    @IBOutlet var messageErrorLabel: Array<UILabel> = []
    @IBOutlet weak var signInButton: TransitionButton?
    @IBOutlet weak var registerButton: TransitionButton?
    @IBOutlet weak var showPasswordButton: UIButton!
    
    let userDefault = UserDefaults.standard
    let remember = "remember"
    let username = "username"
    let password = "password"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(dismissKeyboard())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        self.view.setGradientBackground(colorTop: UIColor(red: 247/255, green: 152/255, blue: 136/255, alpha: 1.0),
                                        colorBottom: UIColor(red: 63/255, green: 95/255, blue: 155/255, alpha: 1.0))
        self.showPasswordButton.tintColor = UIColor.white
        
        if userDefault.bool(forKey: remember) {
            if let username = userDefault.string(forKey: username), let password = userDefault.string(forKey: password) {
                rememberImage?.image = UIImage(named: "checked")
                usernameTextField?.text = username
                passwordTextField?.text = password
            }
        } else {
            rememberImage?.image = UIImage(named: "unchecked")
            usernameTextField?.text = ""
            passwordTextField?.text = ""
        }
        
        
        showLoading()
        
        passwordTextField?.addTarget(self, action: #selector(textFieldPasswordWasTapped), for: .touchDown)
        
    }
    
    
    @objc func textFieldPasswordWasTapped() {
        showPasswordButton.isHidden = false
    }
    
    
    @IBAction func showAndHidePassword(_ sender: Any) {
        if passwordTextField?.isSecureTextEntry ?? true {
            passwordTextField?.isSecureTextEntry = false
        } else {
            passwordTextField?.isSecureTextEntry = true
        }
    }
    
    @IBAction func rememberButtonTapped(_ sender: Any) {
        if userDefault.bool(forKey: remember) {
            userDefault.set(false, forKey: remember)
            rememberImage?.image = UIImage(named: "unchecked")
            print("ta false")
        } else {
            rememberImage?.image = UIImage(named: "checked")
            userDefault.set(true, forKey: remember)
            print("ta true")
        }
    }
    
    @IBAction func signButtonTapped(_ sender: Any) {
        guard let username = usernameTextField?.text else { return }
        guard let password = passwordTextField?.text else { return }
        
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
        
        signButton?.startAnimation() // 2: Then start the animation when the user tap the button
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            
            
            Auth.auth().signIn(withEmail: username, password: password, completion: { (user, error) in
                if let u = user {
                    DispatchQueue.main.async(execute: { () -> Void in
                        self.signButton?.stopAnimation(animationStyle: .normal, completion: {
                            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as? MainViewController {
                                self.messageErrorLabel[2].isHidden = true
                                self.navigationController?.isNavigationBarHidden = false
                                self.navigationController?.pushViewController(vc, animated: true)
                                
                                if self.userDefault.bool(forKey: self.remember) {
                                    self.userDefault.set(username, forKey: self.username)
                                    self.userDefault.set(password, forKey: self.password)
                                } else {
                                    self.userDefault.removeObject(forKey: self.username)
                                    self.userDefault.removeObject(forKey: self.password)
                                }
                            }
                        })
                    })
                } else {
                    DispatchQueue.main.async(execute: { () -> Void in
                        self.signButton?.stopAnimation(animationStyle: .shake, completion: {
                                UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
                                    self.messageErrorLabel[2].isHidden = false
                                })
                            print("erro login")
                        })
                    })
                }
            })
            
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

extension LoginViewController: UITextFieldDelegate {}
