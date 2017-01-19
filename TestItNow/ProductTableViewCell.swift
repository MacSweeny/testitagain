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
        let cell = ProductTableViewCell(style: .subtitle, reuseIdentifier: reuseIdentifier)
        cell.selectionStyle = .none
        return cell
    }
    
    var product: [AnyHashable: Any]? {
        didSet {
            textLabel?.text = product?["name"] as? String
            detailTextLabel?.text = product?["category"] as? String
            imageView?.image = UIImage.TIN_imageWithColor(.white)
            
            if let urlString = product?["image_url"] as? String, let imageUrl = URL(string: urlString) {
                _ = SessionManager.sharedInstance.fetchImage(for: imageUrl, completion: { image, error in
                    if error == nil {
                        DispatchQueue.main.async(execute: {
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
        imageView?.image = UIImage.TIN_imageWithColor(.white)
    }
    
}
