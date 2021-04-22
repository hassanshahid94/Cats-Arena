//
//  Constants.swift
//  CatsViewer
//
//  Created by Hassan on 18.4.2021.
//

import Foundation
import UIKit

struct Constants{
    
    static let baseURL = "https://api.thecatapi.com/"
    static let apiKey =  "9b7e282d-2a67-4c7b-a9fd-3f3e4056e949"
    static let UDID = UIDevice.current.identifierForVendor?.uuidString
    
}

struct CacheValue {
    static let allCatsData = "allCatsData"
    static let favouriteData = "favouriteData"
    static let breedsData = "breedsData"
    
}
