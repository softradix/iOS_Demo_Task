//
//  MeditationModelBase.swift
//  TristanDemo
//
//  Created by anand singh on 06/03/21.
//

import Foundation
import ObjectMapper

class Meditations : Mappable {
    var background_image_url : String?
    var description : String?
    var featured_position : String?
    var free : Bool?
    var image_url : String?
    var meditation_of_the_day_date : String?
    var meditation_of_the_day_description : String?
    var new_until : String?
    var play_count : Int?
    var position : Int?
    var release_date : String?
    var search_tags : [Search_tags]?
    var sections : String?
    var teacher_name : String?
    var teacher_uuid : String?
    var timer_should_count_down : Bool?
    var title : String?
    var uuid : String?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        background_image_url <- map["background_image_url"]
        description <- map["description"]
        featured_position <- map["featured_position"]
        free <- map["free"]
        image_url <- map["image_url"]
        meditation_of_the_day_date <- map["meditation_of_the_day_date"]
        meditation_of_the_day_description <- map["meditation_of_the_day_description"]
        new_until <- map["new_until"]
        play_count <- map["play_count"]
        position <- map["position"]
        release_date <- map["release_date"]
        search_tags <- map["search_tags"]
        sections <- map["sections"]
        teacher_name <- map["teacher_name"]
        teacher_uuid <- map["teacher_uuid"]
        timer_should_count_down <- map["timer_should_count_down"]
        title <- map["title"]
        uuid <- map["uuid"]
    }

}

class Search_tags : Mappable {
    var related_terms : [String]?
    var title : String?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        related_terms <- map["related_terms"]
        title <- map["title"]
    }

}
