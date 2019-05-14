//
//  SettingMenuBar.swift
//  EmojiSticker
//
//  Created by dely on 14/05/2019.
//  Copyright © 2019 dely. All rights reserved.
//

import UIKit

class SettingMenuBar: NSObject {
    
    let blackView = UIView()
    
    let stickerMenuView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    override init() {
        super.init()
    }
    
    func showSettings() {
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissSetting)))
            
            window.addSubview(blackView)
            window.addSubview(stickerMenuView)
            
            let height: CGFloat = 200
            let y = window.frame.height - height
            stickerMenuView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.0, options: [], animations: {
                self.blackView.alpha = 1
                self.stickerMenuView.frame = CGRect(x: 0, y: y, width: self.stickerMenuView.frame.width, height: self.stickerMenuView.frame.height)
            }, completion: nil)
        }
    }
    
    @objc func dismissSetting() {
        UIView.animate(withDuration: 0.5, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.stickerMenuView.frame = CGRect(x: 0, y: window.frame.height, width: self.stickerMenuView.frame.width, height: self.stickerMenuView.frame.height)
            }
        })
    }
}
