//
//  Presenter.swift
//  PensadorAppiOS
//
//  Created by Gabriel Silva on 21/03/19.
//  Copyright © 2019 Gabriel Silva. All rights reserved.
//

protocol ThinkerDelegate: class {
    func onSuccessCategories(category: [Thinker])
    func onFailure(message: String?)
}

import Foundation

final class MainPresenter {
    
    weak var view: ThinkerDelegate?
    
    init() {}
    
    init(_ view: ThinkerDelegate) {
        self.view = view
    }
    
    func getCategory() {
       ServiceAPI.sharedInstance.getCategories( success: { category in
            self.view?.onSuccessCategories(category: category)
        }, fail: { error in
            self.view?.onFailure(message: error)
        })
    }
}
