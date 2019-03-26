//
//  ViewController.swift
//  PensadorAppiOS
//
//  Created by Gabriel Silva on 21/03/19.
//  Copyright © 2019 Gabriel Silva. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    
    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var presenter: MainPresenter!
    var category: [Thinker] = []
    var selectedRowIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MainPresenter(self)
        
        presenter.getCategory()
        
    }
    
    
    @IBAction func goSearchPage(_ sender: Any) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FrasesViewController") as? PhraseViewController {
            if let text = tfSearch.text, text != "" {
                 vc.txtSearch = text
                navigationController?.pushViewController(vc, animated: true)
            } else {
                showToast(message: "Empty field is not allowed!", color: UIColor(red: 0.8471, green: 0.2706, blue: 0.2706, alpha: 1.0))

            }
        }
    }

}

extension MainViewController: UITableViewDelegate {
    
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 100 {
            return category.count
        } else {
            return category[section].listaCat.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = CategoryCell.identifier
        if tableView.tag == 100 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? CategoryCell {
                cell.lblCategory.text = String(format: "- %@", self.category[indexPath.row].nomePai ?? "")
                if category[indexPath.section].opened {
                    cell.imgExpand.image = UIImage(named: "expand_less")
                } else {
                    cell.imgExpand.image = UIImage(named: "expand_more")
                }
                
                cell.setTableViewDataSourceDelegate(self, forRow: indexPath.row)
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? CategoryInsideCell {
                cell.listCat = category[indexPath.row].listaCat
                cell.lblListCategory.text = category[indexPath.row].listaCat[indexPath.row].nome
                return cell
            }
        }
        return UITableViewCell()
    }
}

extension MainViewController: ThinkerDelegate {
    func onSuccessSearch(category: [Thinker]) {
        return
    }
    
    func onSuccessCategories(category: [Thinker]) {
        self.category = category
        print ("success")
        self.tableView.reloadData()
    }
    
    func onFailure(message: String?) {
        print ("error")
    }
    
    
}

