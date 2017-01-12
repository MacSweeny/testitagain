//
//  SessionManager.swift
//  TestItNow
//
//  Copyright © 2016 Postmates. All rights reserved.
//

import UIKit

class SessionManager {
    
    static let sharedInstance = SessionManager()
    static let errorDomain = "com.postmates.TestItNow"
    
    fileprivate let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
    
    func fetchImage(for url: URL, completion: ((_ image: UIImage?, _ error: NSError?) -> Void)?) -> URLSessionDataTask {
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            var image: UIImage?
            var imageError = error
            
            if error == nil {
                // dumb check to make sure it's an image
                let isImage = response?.mimeType?.contains("image/") ?? false
                
                if isImage, let data = data {
                    image = UIImage(data: data)
                } else {
                    imageError = NSError(domain: SessionManager.errorDomain, code: NSURLErrorCannotParseResponse, userInfo: [NSLocalizedDescriptionKey: "Could not parse image response"])
                }
            }
            
            completion?(image, imageError as NSError?)
        }) 
        task.resume()
        return task
    }
}
