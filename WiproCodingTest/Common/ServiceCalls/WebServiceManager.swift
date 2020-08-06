//
//  WebServiceManager.swift
//  WiproCodingTest
//
//  Created by Shankar lakkimsetti on 22/07/20.
//  Copyright © 2020 Shankar. All rights reserved.
//

import Foundation
import UIKit

class WebServiceManager: NSObject {
    static let sharedInstance: WebServiceManager = {
        let instance = WebServiceManager()
        return instance
    }()
    typealias resultCallBack = (_ data : AnyObject?)->Void
    typealias FailureHandler = (_ error:AnyObject?) -> Void
    
    func fetchCanadaDataFromUrl<T: Decodable>(urlString :  String ,type : T.Type,completionHandler :@escaping resultCallBack , failureHandler :@escaping (FailureHandler)) {
        // Check network Connectivity
        if (!Reachability.isConnectedToNetwork()){
            CustomAlert.showAlertViewWith(title: Alerts.netwokTitle, message: Alerts.netwokMessage)
            ActivityIndicator.hideActivityIndicator()
            return
        }
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                failureHandler(error as AnyObject)
            } else {
                var status : Bool = false
                if let response = response as? HTTPURLResponse {
                    status = (response.statusCode == 200) ? true : false
                }
                if let data = data , status {
                    do {
                        let resultData = String(decoding: data, as: UTF8.self).data(using: .utf8)
                        let decodedResponse = try JSONDecoder().decode(type.self, from: resultData!)
                        completionHandler(decodedResponse as AnyObject)
                    }catch  {
                        failureHandler(ServiceError.inValidParsing as AnyObject)
                    }
                }else {
                    failureHandler(ServiceError.inValidResponse as AnyObject)
                }
            }
        }
        task.resume()
    }
}
