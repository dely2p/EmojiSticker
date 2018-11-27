//
//  ViewController.swift
//  EmojiSticker
//
//  Created by dely on 2018. 11. 15..
//  Copyright © 2018년 dely. All rights reserved.
//

import UIKit
import Vision

let emoji: [String:String] = ["angry":"😠", "disgust":"☹️", "fear":"😨", "laugh":"🤣", "neutral":"😐", "sad":"😭", "surprise":"😮", "smile":"😊", "talking":"🤪"]

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set imageView
        guard let image = UIImage(named: "sample2") else { return }
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        
        let scaledHeight = view.frame.width / image.size.width * image.size.height
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: scaledHeight)
        imageView.backgroundColor = .blue
        print("CGRect: \(view.frame.width), \(scaledHeight)")
        
        // set button
        let button = UIButton(frame: CGRect(x: 100, y: 300, width: 100, height: 50))
        button.backgroundColor = .green
        button.setTitle("get emotion", for: .normal)
        button.addTarget(self, action: #selector(makeEmojiByFaceEmotion), for: .touchUpInside)
        
        view.addSubview(imageView)
        view.addSubview(button)
        
        
        // set URLSession
        let sessionManager = URLSessionManager()
        guard let imageOfChoice = imageView.image else { return }
        sessionManager.makeURLSession(image: imageOfChoice)
    }
    
    @objc func makeEmojiByFaceEmotion(sender: UIButton!) {
        do {
            guard let faceObject = UserDefaults.standard.object(forKey: "faceObject") as? Data else { return }
            guard let unarchiveObject = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(faceObject) as? Data else { return }
            let data = try JSONDecoder().decode(FaceInfo.self, from: unarchiveObject)
            makeSticker(faces: data.faces)
        } catch {
            print("unarchive err")
        }
        
    }
    
    func makeSticker(faces: [Faces]) {
        for face in faces {
            let label = UILabel(frame: CGRect(x: face.roi.x/3, y: face.roi.y/3, width: face.roi.width/2, height: face.roi.height/2))

            label.textAlignment = .center
            label.adjustsFontSizeToFitWidth = true
            label.font = label.font.withSize(CGFloat(face.roi.width/2))
            label.text = emoji[face.emotion.value]
            self.view.addSubview(label)
        }
    }
}
