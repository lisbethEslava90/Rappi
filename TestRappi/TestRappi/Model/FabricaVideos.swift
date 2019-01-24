//
//  FabricaVideos.swift
//  TestRappi
//
//  Created by Lisbeth Eslava on 1/21/19.
//  Copyright © 2019 Lisbeth Eslava. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class FabricaVideos {
    
    var arrayVideosJson = Videos()
    
    var urlVideo = ""
    
    var idMovieL = 0
    
    init(tipo: Int, idMovie: Int) {
        self.idMovieL = idMovie
        getUrl(tipo: tipo)
    }
    
    func getUrl(tipo: Int){
        if(tipo == 1){
            urlVideo = "https://api.themoviedb.org/3/movie/\(self.idMovieL)/videos?api_key=409a3e7ecd202ae9fb2d2704ab356d64"
        }
        if(tipo == 2){
             urlVideo = "https://api.themoviedb.org/3/tv/\(self.idMovieL)/videos?api_key=409a3e7ecd202ae9fb2d2704ab356d64"
        }
        
        scrappingTrailer(urlVideos: urlVideo)
    }
    
    func scrappingTrailer(urlVideos: String){
        Alamofire.request(urlVideos).responseJSON { (respuesta) in
            if respuesta.result.isSuccess{
                if let answer = respuesta.result.value{
                    self.arrayVideosJson = Mapper<Videos>().map(JSON: answer as! [String : Any])!
                }
            }
        }
    }
    
}
