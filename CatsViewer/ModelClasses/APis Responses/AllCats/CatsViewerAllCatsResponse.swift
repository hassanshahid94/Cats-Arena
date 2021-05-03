//
//  CatsViewerAllCatsResponse.swift
//  CatsViewer
//
//  Created by Hassan on 21.4.2021.
//

import Foundation 
import ObjectMapper


class CatsViewerAllCatsResponse : NSObject, Mappable  {

	var breeds : [CatsViewerBreedsResponse]?
	var height : Int?
	var id : String?
	var url : String?
	var width : Int?
    var isFavourtie: Bool!
    var favouriteId: Int!

	class func newInstance(map: Map) -> Mappable? {
		return CatsViewerAllCatsResponse()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map) {
		breeds <- map["breeds"]
		height <- map["height"]
		id <- map["id"]
		url <- map["url"]
		width <- map["width"]
        isFavourtie <- map["isFavourtie"]
        favouriteId <- map["favouriteId"]
		
	}
}
