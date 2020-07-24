//
//  CanadaInfoModel.swift
//  WiproCodingTest
//
//  Created by Shankar lakkimsetti on 22/07/20.
//  Copyright © 2020 Shankar. All rights reserved.
//

import Foundation

struct CanadaDataModel : Decodable {
    
    let title : String
    let rows : [Rows]?
    
}

struct Rows : Decodable {
    
    let title : String?
    let description : String?
    let imageHref : String?
    
}
