//
//  MovieDetailTableViewCell.swift
//  MOViE
//
//  Created by Yelylena on 02.07.2018.
//  Copyright © 2018 Yelylena. All rights reserved.
//

import UIKit

class MovieDetailTableViewCell: UITableViewCell {

    @IBOutlet var overviewLabel: UILabel! {
        didSet {
            overviewLabel.numberOfLines = 0
        }
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
