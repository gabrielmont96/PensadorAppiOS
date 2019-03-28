//
//  CategoryInsideCell.swift
//  PensadorAppiOS
//
//  Created by Gabriel Silva on 22/03/19.
//  Copyright © 2019 Gabriel Silva. All rights reserved.
//

import UIKit

class CategoryInsideCell: UITableViewCell {
    static let identifier = "ListCategoryCell"
    @IBOutlet weak var lblListCategory: UILabel?
    
    var listCat: [ListCat] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code.
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
