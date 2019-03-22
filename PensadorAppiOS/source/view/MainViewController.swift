//
//  ViewController.swift
//  PensadorAppiOS
//
//  Created by Gabriel Silva on 21/03/19.
//  Copyright © 2019 Gabriel Silva. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    var presenter: PensadorPresenter!
    var category: [Pensador] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = PensadorPresenter(self)
        
        presenter.getCategory()
        
        // Do any additional setup after loading the view, typically from a nib.
    }


}

extension MainViewController: UITableViewDelegate {
    
}

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return category.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if category[section].opened {
            return category[section].listaCat.count + 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataIndex = indexPath.row - 1
        let identifier = CategoryCell.identifier
        
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? CategoryCell {
                cell.lblCategory.text = String(format: "- %@", self.category[indexPath.section].nomePai ?? "")
                if category[indexPath.section].opened {
                    cell.imgExpand.image = UIImage(named: "expand_less")
                } else {
                    cell.imgExpand.image = UIImage(named: "expand_more")
                }
                
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? CategoryCell {
                cell.lblCategory.text = String(format: "     %@", self.category[indexPath.section].listaCat[dataIndex].nome ?? "")
                cell.imgExpand.image = nil
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if category[indexPath.section].opened {
            category[indexPath.section].opened = false
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        } else {
            category[indexPath.section].opened = true
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
            tableView.reloadData()
        }
    }
}

extension MainViewController: PensadorDelegate {
    func onSuccessCategories(category: [Pensador]) {
        self.category = category
        print ("success")
        self.tableView.reloadData()
    }
    
    func onFailure(message: String?) {
        print ("error")
    }
    
    
}

