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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
