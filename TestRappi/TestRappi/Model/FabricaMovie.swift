//
//  FabricaMovie.swift
//  TestRappi
//
//  Created by Lisbeth Eslava on 1/10/19.
//  Copyright © 2019 Lisbeth Eslava. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class FabricaMovie {
    
    var moviesTR = Movies()
    var moviesPO = Movies()
    var moviesUP = Movies()
    var seriesTR = Movies()
    var seriesPO = Movies()
    
    var final = false
    
    let headers = [
        "content-type": "application/json;charset=utf-8"
    ]
    
    let params = [
        "api_key" : "409a3e7ecd202ae9fb2d2704ab356d64"
    ]

    init(tipo: Int) {
        let conexion = Connectivity.isConnectedToInternet
        if(conexion){
            scrapping(tipo: tipo)
        }
    }
    
    func scrapping(tipo: Int){
        switch tipo {
        //movies
        case 1:
            loadInfo(urlAPI: "https://api.themoviedb.org/3/movie/top_rated", tipo: 1, category: "TR") //TOP_RATED
            loadInfo(urlAPI: "https://api.themoviedb.org/3/movie/popular", tipo: 1, category: "PO") //POPULAR
            loadInfo(urlAPI: "https://api.themoviedb.org/3/movie/upcoming", tipo: 1, category: "UP") //UPCOMING
        //series
        case 2:
            loadInfo(urlAPI: "https://api.themoviedb.org/3/tv/top_rated", tipo: 2, category: "TR") //TOP_RATED
            loadInfo(urlAPI: "https://api.themoviedb.org/3/tv/popular", tipo: 2, category: "PO") //POPULAR
        default: break
        }
    }
    
    func loadInfo(urlAPI: String, tipo: Int, category: String){
        //peticion a la API con Alamofire
        Alamofire.request(urlAPI, method: .get, parameters: self.params ,headers: self.headers).responseJSON { (respuesta) in
            if respuesta.result.isSuccess{
                if let answer = respuesta.result.value{
                    
                    switch (tipo, category){
                    case (1, "TR"):
                        self.moviesTR = Mapper<Movies>().map(JSON: answer as! [String : Any])!
                    case (1, "PO"):
                        self.moviesPO = Mapper<Movies>().map(JSON: answer as! [String : Any])!
                    case (1, "UP"):
                        self.moviesUP = Mapper<Movies>().map(JSON: answer as! [String : Any])!
                    case (2, "TR"):
                         self.seriesTR = Mapper<Movies>().map(JSON: answer as! [String : Any])!
                    case (2, "PO"):
                        self.seriesPO = Mapper<Movies>().map(JSON: answer as! [String : Any])!
                    case (_, _):
                        break
                    }
                    NotificationCenter.default.post(name: NSNotification.Name("MovieUpdate"), object: nil)
                }
            }else{
                print("No jSON")
            }
        }

        }
    
    func getLengthSeriesTR() -> Int{
        return (seriesTR.movies?.count) != nil ? (seriesTR.movies?.count)!: 0
    }
    
    func getLengthSeriesPO() -> Int{
        return (seriesPO.movies?.count) != nil ? (seriesPO.movies?.count)!: 0
    }
    
    func getLengthMoviesTR() -> Int{
        return (moviesTR.movies?.count) != nil ? (moviesTR.movies?.count)!: 0
    }
    
    func getLengthMoviesPO() -> Int{
        return (moviesPO.movies?.count) != nil ? (moviesPO.movies?.count)!: 0
    }
    
    func getLengthMoviesUP() -> Int{
        return (moviesUP.movies?.count) != nil ? (moviesUP.movies?.count)!: 0
    }
    
}
