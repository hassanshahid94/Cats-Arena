//
//  CatsViewerImage.swift
//  CatsViewer
//
//  Created by Hassan on 21.4.2021.
//

import Foundation 
import ObjectMapper


class CatsViewerImage : NSObject, Mappable {

	var height : Int?
	var id : String?
	var url : String?
	var width : Int?

	class func newInstance(map: Map) -> Mappable? {
		return CatsViewerImage()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map) {
		height <- map["height"]
		id <- map["id"]
		url <- map["url"]
		width <- map["width"]
	}
}
