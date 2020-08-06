//
//  CanadaViewModel.swift
//  WiproCodingTest
//
//  Created by Shankar lakkimsetti on 22/07/20.
//  Copyright © 2020 Shankar. All rights reserved.
//

import Foundation
import UIKit

class CanadaViewModel {
    var reloadDataCompletionBlock: (()->())? = nil
    var canadaData : CanadaDataModel? {
        didSet{
            self.reloadDataCompletionBlock?()
        }
    }
    
    // MARK: - Fetch Canada Data
    func fetchCanadaData() {
        ActivityIndicator.showActivityIndicator()
        WebServiceManager.sharedInstance.fetchCanadaDataFromUrl(urlString: AppUrls.baseUrl, type: CanadaDataModel.self, completionHandler: { [weak self] (responseData) in
            guard let self = self else { return }
            self.canadaData = responseData as? CanadaDataModel
            ActivityIndicator.hideActivityIndicator()
        }) { (errorObject) in
            if let errorMsg = errorObject  {
                CustomAlert.showAlertViewWith(title: Alerts.title, message: (errorMsg is String) ? (errorMsg as! String) : ServiceError.inValidResponse)
            }
            ActivityIndicator.hideActivityIndicator()
        }
    }
}
