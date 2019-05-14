//
//  SettingMenuBar.swift
//  EmojiSticker
//
//  Created by dely on 14/05/2019.
//  Copyright © 2019 dely. All rights reserved.
//

import UIKit

let StickerItem: [String] = ["p_smile", "d_smile"]

class SettingMenuBar: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let blackView = UIView()
    var indexOfSelectedSticker: Int = 0
    
    let stickerMenuView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        cv.alwaysBounceVertical = true
        return cv
    }()
    
    let stickers: [Stickers] = {
        return [Stickers(named: "p_smile"), Stickers(named: "d_smile")]
    }()
    
    override init() {
        super.init()
        
        stickerMenuView.dataSource = self
        stickerMenuView.delegate = self
        stickerMenuView.register(StickerCollectionViewCell.self, forCellWithReuseIdentifier: StickerCollectionViewCell.identifier)
    }
    
    func showSettings() {
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor.init(white: 0, alpha: 0.2)
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stickers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StickerCollectionViewCell.identifier, for: indexPath) as! StickerCollectionViewCell
        let stickerSetting = stickers[indexPath.item]
        cell.setting = stickerSetting
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        indexOfSelectedSticker = indexPath.item
        NotificationCenter.default.post(name: NSNotification.Name("updateStickerImage"), object: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width/4, height: collectionView.bounds.height/3)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) //.zero
    }

}
