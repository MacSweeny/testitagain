//
//  UIImage+TIN.swift
//  TestItNow
//
//  Created by Kevin Ballard on 7/11/16.
//  Copyright © 2016 Postmates. All rights reserved.
//

import UIKit

extension UIImage {
    func TIN_imageScaledToSize(_ size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
    
    class func TIN_imageWithColor(_ color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        defer { UIGraphicsEndImageContext() }
        
        color.setFill()
        UIRectFill(rect)
        
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
}
