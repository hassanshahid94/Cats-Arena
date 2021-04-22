//
//  CatsViewerBreedsResponse.swift
//  CatsViewer
//
//  Created by Hassan on 21.4.2021.
//

import Foundation 
import ObjectMapper


class CatsViewerBreedsResponse : NSObject, Mappable{

	var adaptability : Int?
	var affectionLevel : Int?
	var altNames : String?
	var bidability : Int?
	var catFriendly : Int?
	var cfaUrl : String?
	var childFriendly : Int?
	var countryCode : String?
	var countryCodes : String?
	var descriptionField : String?
	var dogFriendly : Int?
	var energyLevel : Int?
	var experimental : Int?
	var grooming : Int?
	var hairless : Int?
	var healthIssues : Int?
	var hypoallergenic : Int?
	var id : String?
	var image : CatsViewerImage?
	var indoor : Int?
	var intelligence : Int?
	var lap : Int?
	var lifeSpan : String?
	var name : String?
	var natural : Int?
	var origin : String?
	var rare : Int?
	var referenceImageId : String?
	var rex : Int?
	var sheddingLevel : Int?
	var shortLegs : Int?
	var socialNeeds : Int?
	var strangerFriendly : Int?
	var suppressedTail : Int?
	var temperament : String?
	var vcahospitalsUrl : String?
	var vetstreetUrl : String?
	var vocalisation : Int?
	var weight : CatsViewerWeight?
	var wikipediaUrl : String?


	class func newInstance(map: Map) -> Mappable?{
		return CatsViewerBreedsResponse()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		adaptability <- map["adaptability"]
		affectionLevel <- map["affection_level"]
		altNames <- map["alt_names"]
		bidability <- map["bidability"]
		catFriendly <- map["cat_friendly"]
		cfaUrl <- map["cfa_url"]
		childFriendly <- map["child_friendly"]
		countryCode <- map["country_code"]
		countryCodes <- map["country_codes"]
		descriptionField <- map["description"]
		dogFriendly <- map["dog_friendly"]
		energyLevel <- map["energy_level"]
		experimental <- map["experimental"]
		grooming <- map["grooming"]
		hairless <- map["hairless"]
		healthIssues <- map["health_issues"]
		hypoallergenic <- map["hypoallergenic"]
		id <- map["id"]
		image <- map["image"]
		indoor <- map["indoor"]
		intelligence <- map["intelligence"]
		lap <- map["lap"]
		lifeSpan <- map["life_span"]
		name <- map["name"]
		natural <- map["natural"]
		origin <- map["origin"]
		rare <- map["rare"]
		referenceImageId <- map["reference_image_id"]
		rex <- map["rex"]
		sheddingLevel <- map["shedding_level"]
		shortLegs <- map["short_legs"]
		socialNeeds <- map["social_needs"]
		strangerFriendly <- map["stranger_friendly"]
		suppressedTail <- map["suppressed_tail"]
		temperament <- map["temperament"]
		vcahospitalsUrl <- map["vcahospitals_url"]
		vetstreetUrl <- map["vetstreet_url"]
		vocalisation <- map["vocalisation"]
		weight <- map["weight"]
		wikipediaUrl <- map["wikipedia_url"]
		
    }
}
