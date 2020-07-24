//
//  UIView+Extension.swift
//  WiproCodingTest
//
//  Created by Shankar lakkimsetti on 23/07/20.
//  Copyright © 2020 Shankar. All rights reserved.
//

import Foundation
import UIKit


let imageCache = NSCache<NSString, AnyObject>()
extension UIImageView {
    func loadImageUsingCache(withUrl urlString : String , placeHolder: UIImage?) {
        let url = URL(string: urlString)
        self.image = nil
        //download image from url
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {
                    self.image = placeHolder
                }
                return
            }
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                }else {
                    DispatchQueue.main.async {
                        self.image = placeHolder
                    }
                }
            }
        }).resume()
    }
}
