//
//  CatsViewerFavouriteResponse.swift
//  CatsViewer
//
//  Created by Hassan on 21.4.2021.
//

import Foundation 
import ObjectMapper

class CatsViewerFavouriteResponse : NSObject, Mappable{

	var createdAt : String?
	var id : Int?
	var image : CatsViewerImage?
	var imageId : String?
	var subId : String?
	var userId : String?


	class func newInstance(map: Map) -> Mappable?{
		return CatsViewerFavouriteResponse()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		createdAt <- map["created_at"]
		id <- map["id"]
		image <- map["image"]
		imageId <- map["image_id"]
		subId <- map["sub_id"]
		userId <- map["user_id"]
		
    }
}
