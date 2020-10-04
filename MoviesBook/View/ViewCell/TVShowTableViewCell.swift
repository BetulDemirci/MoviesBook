//
//  TVShowTableViewCell.swift
//  MoviesBook
//
//  Created by Semafor on 3.10.2020.
//  Copyright © 2020 Semafor. All rights reserved.
//

import UIKit

class TVShowTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
