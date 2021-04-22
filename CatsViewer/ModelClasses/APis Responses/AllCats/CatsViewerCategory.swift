//
//  CatsViewerCategory.swift
//  CatsViewer
//
//  Created by Hassan on 21.4.2021.
//

import Foundation
import ObjectMapper

class CatsViewerCategory: NSObject, Mappable {
     var id: Int?
     var name: String?

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}
