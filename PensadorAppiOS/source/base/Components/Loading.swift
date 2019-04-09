//
//  Loading.swift
//  PensadorAppiOS
//
//  Created by Gabriel Silva on 02/04/19.
//  Copyright © 2019 Gabriel Silva. All rights reserved.
//

import Lottie

class Loading: LottieView {
    var loadingView: Loading?
    
    init(frame: CGRect, center: CGPoint, moveCenterY: CGFloat = 0) {
        super.init(frame: frame)
        
        createLoading(frame: frame, center: center, moveCenterY: moveCenterY)
        
    }
    
    func createLoading(frame: CGRect, center: CGPoint, moveCenterY: CGFloat) {
        self.frame = frame
        self.center = center
        
        let loading = AnimationView(name: "loading")
        loading.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        loading.center = CGPoint(x: center.x, y: center.y + moveCenterY)
        loading.animationSpeed = 1
        loading.loopMode = .loop
        
        self.addSubview(loading)
        
        loading.play()
    }
    
    func showLoading() -> UIView {
        if loadingView == nil {
            loadingView = Loading(frame: frame, center: center)
        }
        if let loadingView = self.loadingView, loadingView.superview == nil {
            return loadingView
        }
        return UIView.init()
    }
    
    func dismissLoading() {
        if let loadingView = self.loadingView, let _ = loadingView.superview {
            loadingView.removeFromSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
