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
        showActivityIndicator()
        WebServiceManager.sharedInstance.fetchCanadaDataFromUrl(urlString: AppUrls.baseUrl, type: CanadaDataModel.self, completionHandler: { [weak self] (responseData) in
            guard let dataSelf = self else {
                return
            }
            dataSelf.canadaData = responseData as? CanadaDataModel
            hideActivityIndicator()
        }) { (errorObject) in
            if let errorMsg = errorObject  {
                CustomAlert.showAlertViewWith(title: Alerts.title.rawValue, message: (errorMsg is String) ? (errorMsg as! String) : ServiceError.inValidResponse.rawValue)
            }
            hideActivityIndicator()
        }
    }
}
