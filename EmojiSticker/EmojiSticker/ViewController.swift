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
        
        let request = VNDetectFaceRectanglesRequest { (req, err) in
            if let err = err {
                print("failed to detect faces: ", err)
                return
            }
            req.results?.forEach({(res) in
                let redView = UIView()
                redView.backgroundColor = .red
                redView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
                self.view.addSubview(redView)
                
                guard let faceObservation = res as? VNFaceObservation else { return }
                print(faceObservation.boundingBox)
            })
        }

        guard let cgImage = image.cgImage else {
            return
        }

        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        do {
            try handler.perform([request])
        } catch let reqErr {
            print("Failed to perform request: ", reqErr)
        }
    }

}

