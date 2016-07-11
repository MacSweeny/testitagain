//
//  TINProducts.swift
//  TestItNow
//
//  Created by Kevin Ballard on 7/11/16.
//  Copyright © 2016 Postmates. All rights reserved.
//

import Foundation

class TINProducts: NSObject {
    static let products: [[NSObject: AnyObject]] = {
        // we're not going to worry about error handling while reading in this file
        // we can safely assume for the purpose of this project that the JSON is sane
        let jsonFilePath = NSBundle.mainBundle().pathForResource("products", ofType: "json")!
        let jsonData = NSData(contentsOfFile: jsonFilePath)!
        return try! NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers) as! [[NSObject: AnyObject]]
    }()
}
