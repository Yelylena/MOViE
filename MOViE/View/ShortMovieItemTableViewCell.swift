//
//  ShortMovieItemTableViewCell.swift
//  MOViE
//
//  Created by Yelylena on 17.05.2018.
//  Copyright © 2018 Yelylena. All rights reserved.
//

import UIKit

class ShortMovieItemTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
