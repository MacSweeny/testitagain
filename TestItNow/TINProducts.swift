//
//  TINProducts.swift
//  TestItNow
//
//  Created by Kevin Ballard on 7/11/16.
//  Copyright © 2016 Postmates. All rights reserved.
//

import Foundation

class TINProducts: NSObject {
    static let products: [[AnyHashable: Any]] = {
        // we're not going to worry about error handling while reading in this file
        // we can safely assume for the purpose of this project that the JSON is sane
        let jsonFilePath = Bundle.main.path(forResource: "products", ofType: "json")!
        let jsonData = try! Data(contentsOf: URL(fileURLWithPath: jsonFilePath))
        return try! JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as! [[AnyHashable: Any]]
    }()
}
