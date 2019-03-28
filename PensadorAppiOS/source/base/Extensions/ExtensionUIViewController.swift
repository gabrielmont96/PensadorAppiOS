//
//  ExtensionUIViewController.swift
//  PensadorAppiOS
//
//  Created by Gabriel Silva on 26/03/19.
//  Copyright © 2019 Gabriel Silva. All rights reserved.
//

import UIKit

enum modeToast {
    case error
    case success
    case warning
}

extension UIViewController {
    
    func showToast(message : String, mode: modeToast) {
        let toastLabel = UILabel(frame: CGRect(x: 0,
                                               y: self.view.frame.size.height - 50,
                                               width:self.view.frame.size.width ,
                                               height: self.view.frame.size.height - (self.view.frame.size.height - 50)))
        switch mode {
            case .error:
                toastLabel.backgroundColor = UIColor(red: 0.8471, green: 0.2706, blue: 0.2706, alpha: 1.0)
            
            case.success:
                toastLabel.backgroundColor = UIColor(red: 0, green: 0.6667, blue: 0.4431, alpha: 1.0)
            
            case.warning:
                toastLabel.backgroundColor = UIColor.orange
        }
        
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
