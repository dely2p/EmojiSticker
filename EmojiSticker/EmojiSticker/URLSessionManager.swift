//
//  URLSessionManager.swift
//  EmojiSticker
//
//  Created by dely on 2018. 11. 22..
//  Copyright © 2018년 dely. All rights reserved.
//

import UIKit

class URLSessionManager {
    
    func makeURLSession(image: UIImage) {
        // set URLSession
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        guard let url = URL(string: "https://openapi.naver.com/v1/vision/face") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = generateBoundaryString()
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("amhZeyPiHsDSugB9Pifg", forHTTPHeaderField: "X-Naver-Client-Id")
        request.addValue("fPwJI_FlhX", forHTTPHeaderField: "X-Naver-Client-Secret")
        
        guard let imageData = image.jpegData(compressionQuality: 1) else { return }
        
        let param: [String:String]? = nil
        
        request.httpBody = createBodyWithParameters(parameters: param, filePathKey: "image", imageDataKey: imageData, boundary: boundary) as Data
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else { return }

            do{
                let archivedObject = try NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding: false)
                UserDefaults.standard.set(archivedObject, forKey: "faceObject");
            
            } catch {
                print("archive error")
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

