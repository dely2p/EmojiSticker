//
//  FaceInfo.swift
//  EmojiSticker
//
//  Created by dely on 2018. 11. 22..
//  Copyright © 2018년 dely. All rights reserved.
//

import Foundation

struct FaceInfo: Decodable {
    let info : Info
    let faces : [Faces]
}
