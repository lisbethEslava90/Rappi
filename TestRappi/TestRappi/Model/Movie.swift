//
//  Movie.swift
//  TestRappi
//
//  Created by Lisbeth Eslava on 1/11/19.
//  Copyright © 2019 Lisbeth Eslava. All rights reserved.
//

import Foundation
import ObjectMapper
import UIKit

class Movie: Mappable {
    var id: Int?
    var name : String?
    var title : String?
    var description : String?
    var poster_path : String?
    var adult : Bool?
    var overview : String?
    var release_date : String?
    var original_language : String?
    var popularity : Double?
    var vote_count : Int?
    var vote_average : Double?
    var page : Int?
    var first_air_date : String?
    
    var imagenMovie = UIImageView(image: UIImage(named: "movieFondo.png"))

    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.name <- map["name"]
        self.title <- map["title"]
        self.description <- map["description"]
        self.poster_path <- map["poster_path"]
        self.adult <- map["adult"]
        self.overview <- map["overview"]
        self.release_date <- map["release_date"]
        self.original_language <- map["original_language"]
        self.popularity <- map["popularity"]
        self.vote_count <- map["vote_count"]
        self.vote_average <- map["vote_average"]
        self.page <- map["page"]
        self.first_air_date <- map["first_air_date"]
    }
    
    func getUrlImage(jpg: String) -> String{
        return "https://image.tmdb.org/t/p/w300\(jpg)"
    }
    
    func getUrlImageBig(jpg: String) -> String{
        return "https://image.tmdb.org/t/p/w1280\(jpg)"
    }
    
    func getYearSerie() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd"
        let date = dateFormatter.date(from: first_air_date!)
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date!)
        
        return "\(year)"
    }
    
    func getYearMovie() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd"
        let date = dateFormatter.date(from: release_date!)
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date!)

        return "\(year)"
    }
    
    func getImagen() -> UIImage {
        let imagen = imagenMovie.downloadedFromUIImage(url: URL(string: getUrlImage(jpg: self.poster_path!))!)
        return imagen
    }
}
