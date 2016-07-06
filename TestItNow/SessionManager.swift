//
//  SessionManager.swift
//  TestItNow
//
//  Copyright © 2016 Postmates. All rights reserved.
//

import Foundation

class SessionManager {
    
    static let sharedInstance = SessionManager()
    static let errorDomain = "com.postmates.TestItNow"
    
    private let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: nil, delegateQueue: nil)
    
    func fetchImage(for url: NSURL, completion: ((image: UIImage?, error: NSError?) -> Void)?) -> NSURLSessionDataTask {
        let task = session.dataTaskWithURL(url) { data, response, error in
            var image: UIImage?
            var imageError = error
            
            if error == nil {
                // dumb check to make sure it's an image
                let isImage = response?.MIMEType?.containsString("image/") ?? false
                
                if isImage, let data = data {
                    image = UIImage(data: data)
                } else {
                    imageError = NSError(domain: SessionManager.errorDomain, code: NSURLErrorCannotParseResponse, userInfo: [NSLocalizedDescriptionKey: "Could not parse image response"])
                }
            }
            
            completion?(image: image, error: imageError)
        }
        task.resume()
        return task
    }
}