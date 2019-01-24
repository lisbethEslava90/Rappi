//
//  Video.swift
//  TestRappi
//
//  Created by Lisbeth Eslava on 1/21/19.
//  Copyright © 2019 Lisbeth Eslava. All rights reserved.
//

import Foundation
import ObjectMapper

class Videos: Mappable{
    var id: Int?
    var videosDetail: [Video]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.id           <- map["id"]
        self.videosDetail        <- map["results"]
    }

}


///////////////////////////////////////
class Video: Mappable{
    var id: String?
    var key: String?
    var name: String?
    var site: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.key <- map["key"]
        self.name <- map["name"]
        self.site <- map["site"]
    }
    
    func  getUrlReproducir() -> String {
        return "https://www.youtube.com/watch?v=\(self.key ?? "")"
    }
}
