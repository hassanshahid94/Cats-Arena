//
//  Parameters.swift
//  CatsViewer
//
//  Created by Hassan on 21.4.2021.
//

import Foundation
import ObjectMapper

//GetCats API Body
class AllCatsBody: NSObject, Mappable {
     var size: String?
     var order: String?
     var page: Int?
     var limit: Int?
     var  hasBreed: Bool?
     var breedIds: String?

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        size <- map["size"]
        order <- map["order"]
        page <- map["page"]
        limit <- map["limit"]
        hasBreed <- map["hasBreed"]
        breedIds <- map["breedIds"]
    }
}

//GetBreeds API Body
class BreedsBody: NSObject, Mappable {
     var limit: String?
     var page: String?

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        limit <- map["limit"]
        page <- map["page"]
    }
}

//GetFavouritesCats API Body
class FavourtieBody: NSObject, Mappable {
     var subId: String?

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        subId <- map["sub_id"]
    }
}

//AddFavourtie API Body
class AddFavouriteBody: NSObject, Mappable {
     var subId: String?
     var imageId: String?

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        subId <- map["sub_id"]
        imageId <- map["image_id"]
    }
}

//Delete Favourtie API body
class DeleteFavouriteBody: NSObject, Mappable {
     var favouriteId: Int?

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        favouriteId <- map["favouriteId"]
    }
}


