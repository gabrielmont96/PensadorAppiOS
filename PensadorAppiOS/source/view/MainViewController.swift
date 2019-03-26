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
    @IBOutlet weak var tableView: UITableView! {
        didSet {
//            tableView.delegate = self
//            tableView.dataSource = self
        }
    }
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
                let alert = UIAlertController(title: "CAMPO EM BRANCO", message: "Digite algo para pesquisar!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Fechar", style: .cancel, handler: nil))
                self.present(alert, animated: true)

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
//        let dataIndex = indexPath.row - 1
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
    
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if tableView.tag == 100 {
//            return 150
//        } else {
//            return 200
//        }
//
//    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if selectedRowIndex != indexPath.row {
//            if category[indexPath.section].opened {
//                category[indexPath.section].opened = false
//                let sections = IndexSet.init(integer: indexPath.section)
//                tableView.reloadSections(sections, with: .none)
//            } else {
//                category[indexPath.section].opened = true
//                let sections = IndexSet.init(integer: indexPath.section)
//                tableView.reloadSections(sections, with: .none)
//                tableView.reloadData()
//            }
//        }
//            self.selectedRowIndex = indexPath.row
//            self.tableView.beginUpdates()
//            self.tableView.endUpdates()
//    }
}

extension MainViewController: PensadorDelegate {
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

