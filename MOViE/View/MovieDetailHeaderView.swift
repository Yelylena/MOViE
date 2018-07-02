//
//  MovieDetailHeaderView.swift
//  MOViE
//
//  Created by Yelylena on 02.07.2018.
//  Copyright © 2018 Yelylena. All rights reserved.
//

import UIKit

class MovieDetailHeaderView: UIView {

    @IBOutlet var posterImageView: UIImageView!
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
    @IBOutlet var trailerButton: UIButton! {
        didSet {
            trailerButton.layer.cornerRadius = 15
            trailerButton.layer.masksToBounds = true
        }
    }
}
