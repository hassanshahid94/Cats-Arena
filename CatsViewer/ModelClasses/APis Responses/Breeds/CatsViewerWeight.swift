//
//  CatsViewerWeight.swift
//  CatsViewer
//
//  Created by Hassan on 21.4.2021.
//

import Foundation 
import ObjectMapper


class CatsViewerWeight : NSObject, Mappable{

	var imperial : String?
	var metric : String?


	class func newInstance(map: Map) -> Mappable?{
		return CatsViewerWeight()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		imperial <- map["imperial"]
		metric <- map["metric"]
	}
}
