//
//  UIView+Extension.swift
//  WiproCodingTest
//
//  Created by Shankar lakkimsetti on 23/07/20.
//  Copyright © 2020 Shankar. All rights reserved.
//

import Foundation
import UIKit

//MARK:- Load Async Images 
let imageCache = NSCache<NSString, AnyObject>()
extension UIImageView {
    func loadImageUsingCache(withUrl urlString : String , placeHolder: UIImage!) {
        let url = URL(string: urlString)
        self.image = nil
        self.image = placeHolder
        // Check network connectivity
        if (!Reachability.isConnectedToNetwork() && !(UIWindow.key?.rootViewController?.presentedViewController is UIAlertController)){
            CustomAlert.showAlertViewWith(title: Alerts.netwokTitle.rawValue, message: Alerts.netwokMessage.rawValue)
            return
        }
        // Get image from cache if already exists
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = cachedImage
            return
        }
        //download image from url
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    //save Image in cache
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                }
            }
        }).resume()
    }
}
