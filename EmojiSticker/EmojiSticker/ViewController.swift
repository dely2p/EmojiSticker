//
//  ViewController.swift
//  EmojiSticker
//
//  Created by dely on 2018. 11. 15..
//  Copyright © 2018년 dely. All rights reserved.
//

import UIKit
import Vision

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let image = UIImage(named: "sample1") else {
            return
        }
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        
        let scaledHeight = view.frame.width / image.size.width * image.size.height
        
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: scaledHeight)
        imageView.backgroundColor = .blue

        view.addSubview(imageView)
    }

}

