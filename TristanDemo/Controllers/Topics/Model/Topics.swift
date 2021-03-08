//
//  Topis.swift
//  TristanDemo
//
//  Created by anand singh on 06/03/21.
//

import Foundation
import ObjectMapper

class Topics : Mappable {
    var color : String?
    var description : String?
    var description_short : String?
    var featured : Bool?
    var image_url : String?
    var meditations : [String]?
    var parent_uuid : String?
    var position : Int?
    var thumbnail_url : String?
    var title : String?
    var uuid : String?
    var detailedMeditations : [Meditations]?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        color <- map["color"]
        description <- map["description"]
        description_short <- map["description_short"]
        featured <- map["featured"]
        image_url <- map["image_url"]
        meditations <- map["meditations"]
        parent_uuid <- map["parent_uuid"]
        position <- map["position"]
        thumbnail_url <- map["thumbnail_url"]
        title <- map["title"]
        uuid <- map["uuid"]
        detailedMeditations <- map["detailedMeditations"]
    }

}
