//
//  Constants.swift
//  WiproCodingTest
//
//  Created by Sankar Lakkimsetti on 28/07/20.
//  Copyright © 2020 Shankar. All rights reserved.
//

import Foundation
import UIKit

//MARK:- Base URL
let baseURL = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
//MARK:- Serice Errors Messages
enum ServiceError: String, Error{
    case inValidParsing = "Unable to decode data."
    case inValidResponse = "Unable to fetch data."
}
//MARK:- Alerts Title and Messages
enum Alerts: String {
    case netwokTitle = "No Network Connection"
    case netwokMessage = "Please check your internet connection and network settings and try again!!!"
    case title = "Alert"
}
//MARK:- App Theme Color
func appThemeColor() -> UIColor {
    return UIColor(red: 7/255, green: 71/255, blue: 89/255, alpha: 1)
}
//MARK:- Font Names
let helveticaNeueMedium = "HelveticaNeue-Medium"
