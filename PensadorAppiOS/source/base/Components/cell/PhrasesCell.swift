//
//  PhrasesCell.swift
//  PensadorAppiOS
//
//  Created by Gabriel Silva on 25/03/19.
//  Copyright © 2019 Gabriel Silva. All rights reserved.
//

import UIKit
import Kingfisher

class PhrasesCell: UITableViewCell {
    static let identifier = "PhrasesCell"

    @IBOutlet weak var imgHeader: UIImageView?
    @IBOutlet weak var btnCopy: UIButton?
    @IBOutlet weak var btnShare: UIButton?
    @IBOutlet weak var btnFavorite: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imgHeader?.layer.masksToBounds = true
        setupBtnCopy()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupBtnCopy() {
        btnCopy?.layer.masksToBounds = true
        btnCopy?.layer.borderColor = UIColor.white.cgColor
        btnCopy?.layer.cornerRadius = 10
        btnCopy?.layer.borderWidth = 2
        btnCopy?.backgroundColor = UIColor.black
    }
    
    func prepareCell(phrases: Phrase) {
        if let urlEncoded = phrases.imageUrl {
            self.imgHeader?.kf.indicatorType = .activity
            self.imgHeader?.kf.setImage(with: URL(string: urlEncoded))
        }
    }

}
