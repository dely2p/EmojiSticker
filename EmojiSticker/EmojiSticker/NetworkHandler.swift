//
//  NetworkHandler.swift
//  EmojiSticker
//
//  Created by dely on 2018. 11. 16..
//  Copyright © 2018년 dely. All rights reserved.
//

import Foundation

class NetworkHandler {
    func getData(resource: String) {
        
        let session = URLSession(configuration: .default)
        guard let url = URL(string: "https://westcentralus.api.cognitive.microsoft.com/face/v1.0") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }
        task.resume()
        
    }
}
