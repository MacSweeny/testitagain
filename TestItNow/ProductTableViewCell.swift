//
//  ProductTableViewCell.swift
//  TestItNow
//
//  Copyright © 2016 Postmates. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    static let reuseIdentifier = "Product"
    
    static func reusableCell(for tableView: UITableView) -> ProductTableViewCell {
        let cell = ProductTableViewCell(style: .Subtitle, reuseIdentifier: reuseIdentifier)
        cell.selectionStyle = .None
        return cell
    }
    
    var product: [NSObject: AnyObject]? {
        didSet {
            textLabel?.text = product?["name"] as? String
            detailTextLabel?.text = product?["category"] as? String
            imageView?.image = UIImage.TIN_imageWithColor(.whiteColor())
            
            if let urlString = product?["image_url"] as? String, imageUrl = NSURL(string: urlString) {
                SessionManager.sharedInstance.fetchImage(for: imageUrl, completion: { image, error in
                    if error == nil {
                        dispatch_async(dispatch_get_main_queue(), {
                            self.imageView?.image = image
                        })
                    }
                })
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textLabel?.text = nil
        detailTextLabel?.text = nil
        imageView?.image = UIImage.TIN_imageWithColor(.whiteColor())
    }
    
}
