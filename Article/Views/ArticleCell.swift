//
//  ArticleCell.swift
//  Article
//
//  Created by Suraj Pandey on 12/09/19.
//  Copyright © 2019 Sudhir. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var publishDate: UILabel!
    class var identifier: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
