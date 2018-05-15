//
//  ShortMovieItemTableViewCell.swift
//  MOViE
//
//  Created by Yelylena on 15.05.2018.
//  Copyright © 2018 Yelylena. All rights reserved.
//

import UIKit

class ShortMovieItemTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var popularity: UILabel!
    @IBOutlet weak var originalTitle: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    
}
