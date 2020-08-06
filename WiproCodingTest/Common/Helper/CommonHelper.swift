//
//  CommonHelper.swift
//  WiproCodingTest
//
//  Created by Shankar lakkimsetti on 23/07/20.
//  Copyright © 2020 Shankar. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration

// MARK: -  Activity Indicator
public class ActivityIndicator {
    static var activityIndicator = UIActivityIndicatorView.init()
    
    // MARK: - Show Activity Indicator
    class func showActivityIndicator() {
        if #available(iOS 13.0, *) {
            activityIndicator.style = .medium
        } else {
            activityIndicator.style = .gray
        }
        activityIndicator.color = .darkGray
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        let topView = UIWindow.key?.rootViewController!.view
        DispatchQueue.main.async {
            topView!.addSubview(activityIndicator)
            activityIndicator.centerYAnchor.constraint(equalTo:topView!.centerYAnchor ).isActive = true
            activityIndicator.centerXAnchor.constraint(equalTo: topView!.centerXAnchor).isActive = true
        }
    }
    
    // MARK: - Hide Activity Indicator
    class func hideActivityIndicator() {
        DispatchQueue.main.async {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
}

// MARK: - Show Alert
public class CustomAlert {
    class func showAlertViewWith(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
        }
        alertController.addAction(OKAction)
        UIWindow.key?.rootViewController!.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - Check Network Reachbility
public class Reachability {
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        let isReachable = flags == .reachable
        let needsConnection = flags == .connectionRequired
        return isReachable && !needsConnection
    }
}

// MARK: - NavigationController with Status bar style
class CustomNavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

