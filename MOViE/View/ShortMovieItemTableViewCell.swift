//
//  ShortMovieItemTableViewCell.swift
//  MOViE
//
//  Created by Yelylena on 17.05.2018.
//  Copyright © 2018 Yelylena. All rights reserved.
//

import UIKit

class ShortMovieItemTableViewCell: UITableViewCell {

    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var titleLabel: UILabel! {
        didSet {
            titleLabel.numberOfLines = 0
        }
    }
    @IBOutlet var ratingLabel: UILabel! {
        didSet {
            ratingLabel.backgroundColor = UIColor(red: 54, green: 196, blue: 151)
            ratingLabel.layer.cornerRadius = ratingLabel.bounds.width / 2
            ratingLabel.layer.masksToBounds = true
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
