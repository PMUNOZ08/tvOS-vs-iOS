//
//  CollectionViewCell.swift
//  NSCoder_tvOS_UIKit
//
//  Created by Pedro on 2/11/24.
//

import UIKit
import TVUIKit
import Kingfisher
import UnsplashApi
import NSCoder_tvOS_Domain


class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardView: TVCardView!
    @IBOutlet weak var imgView: UIImageView!
    
    override func prepareForReuse() {
        imgView.image = nil
    }
    
    // TVCardView focused size can defined setting  the value for focusSizeIncrease
    func configure(with photo: NSCPhoto) {
        imgView.adjustsImageWhenAncestorFocused = true
        cardView.isUserInteractionEnabled = false
        imgView.kf.setImage(with: URL(string: photo.urlThumbnail ?? ""),
                            options: [.transition(.fade(0.3)), .forceTransition, ])
    }
}
