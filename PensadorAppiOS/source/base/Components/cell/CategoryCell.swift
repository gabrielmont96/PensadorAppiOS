//
//  CategoryTableViewCell.swift
//  PensadorAppiOS
//
//  Created by Gabriel Silva on 22/03/19.
//  Copyright © 2019 Gabriel Silva. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    static let identifier = "CategoryCell"

    @IBOutlet weak var imgExpand: UIImageView!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var insideTableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setup(category: Thinker) {
        lblCategory.text = category.nomePai
    }

}

extension CategoryCell {
    func setTableViewDataSourceDelegate <D:UITableViewDataSource & UITableViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        insideTableView.delegate = dataSourceDelegate
        insideTableView.dataSource = dataSourceDelegate

        insideTableView.reloadData()
    }
}
