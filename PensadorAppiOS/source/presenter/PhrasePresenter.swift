//
//  PhrasePresenter.swift
//  PensadorAppiOS
//
//  Created by Gabriel Silva on 25/03/19.
//  Copyright © 2019 Gabriel Silva. All rights reserved.
//

import Foundation

protocol PhraseDelegate: class {
    func onSuccessSearch(phrases: List)
    func onFailure(message: String?)
}

import Foundation

final class PhrasePresenter {
    
    weak var view: PhraseDelegate?
    
    init() {}
    
    init(_ view: PhraseDelegate) {
        self.view = view
    }
    
    func getPrasesCategoryResult(param: String, page: Int) {
        ServiceAPI.sharedInstance.getCategoryResult(param: param, page: page, success: { [weak self] phrases in
            self?.view?.onSuccessSearch(phrases: phrases)
        }, fail: { error in
            self.view?.onFailure(message: error)
        })
    }
    
    func getSearchResult(param: String, page: Int) {
        ServiceAPI.sharedInstance.getSearchResult(param: param, page: page, success: { [weak self] phrases in
            self?.view?.onSuccessSearch(phrases: phrases)
        }, fail: { error in
            self.view?.onFailure(message: error)
        })
    }
}
