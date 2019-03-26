//
//  ExtensionUIViewController.swift
//  PensadorAppiOS
//
//  Created by Gabriel Silva on 26/03/19.
//  Copyright © 2019 Gabriel Silva. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showToast(message : String, color: UIColor) {
        let toastLabel = UILabel(frame: CGRect(x: 0, y: self.view.frame.size.height-100, width:self.view.frame.size.width , height: self.view.frame.size.height - (self.view.frame.size.height-100)))
        toastLabel.backgroundColor = color
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Bold", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        self.view.addSubview(toastLabel)
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
            UIView.animate(withDuration: 2.0, delay: 0.1, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }, completion: {(isCompleted) in
                toastLabel.removeFromSuperview()
            })
        }
    }
    
}
