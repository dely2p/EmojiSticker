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
        guard let image = UIImage(named: "sample3") else { return }
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        
        let scaledHeight = view.frame.width / image.size.width * image.size.height
        let size = CGSize(width: view.frame.width, height: scaledHeight)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        imageView.frame = rect
        
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        image.draw(in: rect)
        let newImage: UIImage! = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // set button
        let button = UIButton(frame: CGRect(x: 100, y: 300, width: 100, height: 50))
        button.backgroundColor = .green
        button.setTitle("get emotion", for: .normal)
        button.addTarget(self, action: #selector(makeEmojiByFaceEmotion), for: .touchUpInside)
        
        view.addSubview(imageView)
        view.addSubview(button)
        
        
        // set URLSession
        let sessionManager = URLSessionManager()
        guard let imageOfChoice = newImage else { return }
        sessionManager.makeURLSession(image: imageOfChoice)
        
        if let _ = UserDefaults.standard.object(forKey: "faceObject"){
            UserDefaults.standard.removeObject(forKey: "faceObject")
        }
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
            let label = UILabel(frame: CGRect(x: face.roi.x, y: face.roi.y, width: face.roi.width, height: face.roi.height))
            
            label.textAlignment = .center
            label.adjustsFontSizeToFitWidth = true
            label.font = label.font.withSize(CGFloat(face.roi.width))
            label.text = emoji[face.emotion.value]
//            label.backgroundColor = .yellow
            self.view.addSubview(label)
        }
    }
}
