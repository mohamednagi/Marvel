//
//  MarvelSearchCell.swift
//  Marvel
//
//  Created by Sierra on 1/25/20.
//  Copyright © 2020 Nagiz. All rights reserved.
//

import UIKit

class MarvelSearchCell: UITableViewCell {

    @IBOutlet weak var searchImage: UIImageView!
    @IBOutlet weak var searchName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
