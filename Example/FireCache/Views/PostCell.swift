//
//  PostCell.swift
//  FireCache_Example
//
//  Created by Jitendra Gandhi on 19/11/18.
//  Copyright © 2018 itsji10dra.com. All rights reserved.
//

import UIKit

class PostCell: UICollectionViewCell {
    
    // MARK: - IBOutlets

    @IBOutlet weak var userIconImageView: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var postImageView: UIImageView!

    @IBOutlet weak var likesCountLabel: UILabel!

    @IBOutlet weak var likeButton: UIButton!
    
    // MARK: - Blocks

    internal var likeActionBlock: ((_ isSelected: Bool) -> Void)?
    
    // MARK: - IBOutlets Actions
    
    @IBAction func likeButtonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        let isSelected = sender.isSelected
        likeActionBlock?(isSelected)
    }
}
