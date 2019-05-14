//
//  StickerCollectionViewCell.swift
//  EmojiSticker
//
//  Created by dely on 14/05/2019.
//  Copyright © 2019 dely. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func setupImageView() {
    }
}

class StickerCollectionViewCell: BaseCell {
    static var identifier: String = "StickerCell"
    let stickerImage: UIImageView = {
        let image  = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "ryan")
        return image
    }()

    var setting: Stickers? {
        didSet {
            stickerImage.image = setting?.image
        }
    }

    override func setupImageView() {
        super.setupImageView()

        backgroundColor = .yellow
        addSubview(stickerImage)

        stickerImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stickerImage.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stickerImage.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        stickerImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
}
