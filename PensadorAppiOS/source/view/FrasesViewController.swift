//
//  FraseViewController.swift
//  PensadorAppiOS
//
//  Created by Gabriel Silva on 22/03/19.
//  Copyright © 2019 Gabriel Silva. All rights reserved.
//

import UIKit

class PhraseViewController: UIViewController {

    var presenter: PhrasePresenter!
    var txtSearch = ""
    var phrases: [Phrase] = []
    var phraseSelected: Phrase?
    var page = 1
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = PhrasePresenter(self)
        presenter.getPhrases(param: txtSearch, page: page)
    }

    func copyText (text: String) {
        print(text)
    }

}

extension PhraseViewController: UITableViewDelegate {}

extension PhraseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return phrases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = PhrasesCell.identifier
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? PhrasesCell {
            cell.prepareCell(phrases: phrases[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print(indexPath.row)
        if indexPath.item == tableView.numberOfRows(inSection: indexPath.section) - 3 {
            presenter.getPhrases(param: txtSearch, page: page+1)
            page = page+1
        }
    }
    
    
}

extension PhraseViewController: PhraseDelegate {
    func onSuccessSearch(phrases: List) {
        print("")
        for item in phrases.list {
            self.phrases.append(item)
        }
        tableView.reloadData()
    }
    
    func onFailure(message: String?) {
        print(message)
    }
}
