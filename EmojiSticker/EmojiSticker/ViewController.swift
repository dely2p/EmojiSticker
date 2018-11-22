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
        
        // set imageView
        guard let image = UIImage(named: "sample2") else {
            return
        }
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        
        let scaledHeight = view.frame.width / image.size.width * image.size.height
        
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: scaledHeight)
        imageView.backgroundColor = .blue
        
        view.addSubview(imageView)
        
        
        // set URLSession
        guard let url = URL(string: "https://openapi.naver.com/v1/vision/face") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = generateBoundaryString()
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("amhZeyPiHsDSugB9Pifg", forHTTPHeaderField: "X-Naver-Client-Id")
        request.addValue("fPwJI_FlhX", forHTTPHeaderField: "X-Naver-Client-Secret")
//        request.addValue("96703", forHTTPHeaderField: "Content-Length")
        
        guard let imageData = imageView.image?.jpegData(compressionQuality: 1) else { return }
        
        let param: [String:String]? = nil
        
        request.httpBody = createBodyWithParameters(parameters: param, filePathKey: "image", imageDataKey: imageData, boundary: boundary) as Data
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else { return }
            
            do {
                let face = try JSONDecoder().decode(FaceInfo.self, from: data)
//                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
//                    return
//                }
//                let faceInfo = FaceInfo(json: json)
                print(face.faces[0].emotion.value)
            } catch let jsonErr{
                print("Error ", jsonErr)
            }
        }
        task.resume()
        
    }
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: Data, boundary: String) -> NSData {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        
        let filename = "sample1.jpg"
        let mimetype = "image/jpg"
        
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey as Data)
        body.appendString("\r\n")
        body.appendString("--\(boundary)--\r\n")
        
        return body
    }
    
    func generateBoundaryString() -> String {
        return "Boundary-\(UUID().uuidString)"
    }

}

extension NSMutableData {
    
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}

//extension FaceInfo {
//    init?(json: [String:Any]) {
//        guard let faceCount = json["faceCount"] as? Int,
//            let size = json["size"] as? [String:Int],
//            let width = size["width"],
//            let height = size["height"]
//        else {
//            return nil
//        }
//        self.faceCount = faceCount
//        self.size = (width, height)
//    }
//}
