//
//  CategoryInsideCell.swift
//  PensadorAppiOS
//
//  Created by Gabriel Silva on 22/03/19.
//  Copyright © 2019 Gabriel Silva. All rights reserved.
//

import UIKit

class CategoryInsideCell: UITableViewCell {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblListCategory: UILabel!
    
    var listCat: [ListaCat] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code.
        
//        tableView.delegate = self
//        tableView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


//extension CategoryInsideCell: UITableViewDelegate {}
//
//extension CategoryInsideCell: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return listCat.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let identifier = CategoryCell.identifier
//        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? CategoryCell {
//            lblListCategory.text = String(format: "     %@", self.listCat[indexPath.row].nome ?? "")
//            return cell
//        }
//
//        return UITableViewCell()
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 44
//    }
//}

//extension CategoryCell {
//    func setTableViewDataSourceDelegate <D:UITableViewDataSource & UITableViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
//        insideTableView.delegate = dataSourceDelegate
//        insideTableView.dataSource = dataSourceDelegate
//        
//        insideTableView.reloadData()
//    }
//}
