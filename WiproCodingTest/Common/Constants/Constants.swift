//
//  Constants.swift
//  WiproCodingTest
//
//  Created by Sankar Lakkimsetti on 28/07/20.
//  Copyright © 2020 Shankar. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Base URL
struct AppUrls {
    static let baseUrl = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
}

// MARK: - App Constants
struct AppConstants {
    static let cellIdentifier = "canadaCellId"
    static let canadaNavigationTitle = "About Canada"
    static let canadaDefaultTitle = "No Title"
    static let canadaDefaultDescription = "No Description"
    static let placeholderImage = UIImage.init(named: "placeholder")
}

// MARK: - Serice Errors Messages
enum ServiceError: String, Error{
    case inValidParsing = "Unable to decode data."
    case inValidResponse = "Unable to fetch data."
}

// MARK: - Alerts Title and Messages
enum Alerts: String {
    case netwokTitle = "No Network Connection"
    case netwokMessage = "Please check your internet connection and network settings and try again!!!"
    case title = "Alert"
}

// MARK: - App Theme Color
struct AppColors {
    static let themeColor : UIColor = UIColor(red: 7/255, green: 71/255, blue: 89/255, alpha: 1)
}

// MARK: - Font Names
struct AppFonts {
    static let helveticaNeueMedium = "HelveticaNeue-Medium"
}

