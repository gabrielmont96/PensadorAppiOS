//
//  CategoryTableViewCell.swift
//  PensadorAppiOS
//
//  Created by stag on 22/03/19.
//  Copyright © 2019 Gabriel Silva. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    static let identifier = "CategoryCell"
    static let nibName = "CategoryCell"
    

    @IBOutlet weak var imgExpand: UIImageView!
    @IBOutlet weak var lblCategory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setup(category: Pensador) {
        lblCategory.text = category.nomePai
    }

}
