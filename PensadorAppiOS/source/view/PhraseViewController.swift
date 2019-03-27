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
    var titleMainView: String?
    
    @IBOutlet weak var lblTitle: UILabel!
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let titleFromMainView = titleMainView {
            lblTitle.text = titleFromMainView
        } else {
            lblTitle.text = txtSearch
        }
    }
    
    @objc func tapBtnCopy(sender: UIButton) {
        let buttonTag = sender.tag
        if let text = phrases[buttonTag].text {
            UIPasteboard.general.string = text
            showToast(message: "Copied successfully!", color: UIColor(red: 0, green: 0.6667, blue: 0.4431, alpha: 1.0))
        } else {
            showToast(message: "Failed to copy, please try again!", color: UIColor(red: 0.8471, green: 0.2706, blue: 0.2706, alpha: 1.0))
        }
    }
    
    @objc func tapBtnShare(sender: UIButton) {
        let buttonTag = sender.tag
        if let text = phrases[buttonTag].text {
            let vc = UIActivityViewController(activityItems: [text], applicationActivities: [])
            present(vc, animated: true)
        }
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
            cell.btnCopy.addTarget(self, action: #selector(tapBtnCopy(sender:)), for: .touchUpInside)
            cell.btnCopy.tag = indexPath.row
            cell.btnShare.addTarget(self, action: #selector(tapBtnShare(sender:)), for: .touchUpInside)
            cell.btnShare.tag = indexPath.row
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
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
