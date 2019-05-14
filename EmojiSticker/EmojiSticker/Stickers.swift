//
//  Stickers.swift
//  EmojiSticker
//
//  Created by dely on 14/05/2019.
//  Copyright © 2019 dely. All rights reserved.
//

import UIKit

class Stickers: NSObject {
    let image: UIImage
    init(named: String) {
        self.image = UIImage(named: named)!
    }
}
