//
//  HomeMarvelCell.swift
//  Marvel
//
//  Created by Sierra on 1/24/20.
//  Copyright © 2020 Nagiz. All rights reserved.
//

import UIKit

class HomeMarvelCell: UITableViewCell {

    @IBOutlet weak var marvelImage: UIImageView!
    @IBOutlet weak var marvelName: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
