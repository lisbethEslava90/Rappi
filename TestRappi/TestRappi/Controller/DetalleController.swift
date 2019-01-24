//
//  DetalleController.swift
//  TestRappi
//
//  Created by Lisbeth Eslava on 1/17/19.
//  Copyright © 2019 Lisbeth Eslava. All rights reserved.
//
// Controlador asignado a la vista de detalle de la pelicula o serie

import UIKit
import AVKit
import AVFoundation
import youtube_ios_player_helper_swift

class DetalleController: UIViewController {
    
    
    @IBOutlet weak var imageMovieDetail: UIImageView!
    
    @IBOutlet weak var labelAno: UILabel!
    
    @IBOutlet weak var labelPuntuacion: UILabel!
    
    @IBOutlet weak var textfieldDescription: UITextView!
    
    @IBOutlet weak var buttonReproducir: UIButton!
    
    @IBOutlet weak var imageBackground: UIImageView!
    
    @IBOutlet weak var playerView: PlayerView!
    
    var movieDetail = Movie()
    
    var movieDetailCD = MoviesCD()
    
    var tipo = 0
    
    var urlVideo = ""
    
    var videos = FabricaVideos(tipo: 1, idMovie: 1)
    
    var conexion = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        conexion = Connectivity.isConnectedToInternet
        
        if(!conexion){
            buttonReproducir.isEnabled = false
            buttonReproducir.alpha = 0.7
        }
        loadMovieDetail()
        
    }
    

    @IBAction func reproducirVideo(_ sender: UIButton) {
        if(conexion){
            playerView = UINib(nibName: "PlayerView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? PlayerView
            playerView.videoId = videos.arrayVideosJson.videosDetail![0].key!
            addPlayerView()  
        }
    }
    
    func loadMovieDetail(){
        if(conexion){
            imageMovieDetail.downloadedFrom(link: movieDetail.getUrlImageBig(jpg: movieDetail.poster_path!))
            imageBackground.downloadedFrom(link: movieDetail.getUrlImageBig(jpg: movieDetail.poster_path!))
            if(tipo == 1){
                videos = FabricaVideos(tipo: tipo, idMovie: movieDetail.id!)
                labelAno.text = movieDetail.getYearMovie()
            }else if(tipo == 2){
                videos = FabricaVideos(tipo: tipo, idMovie: movieDetail.id!)
                labelAno.text = movieDetail.getYearSerie()
            }
            
            labelPuntuacion.text = "Avg: \(String(movieDetail.vote_average!))"
            textfieldDescription.text = movieDetail.overview
        }else{
            if(tipo == 1){
                labelAno.text = getYearMovie(fecha: movieDetailCD.release_date!)
            }else if(tipo == 2){
                labelAno.text = getYearSerie(fecha: movieDetailCD.release_date!)
            }

            imageMovieDetail.image = UIImage(named: "movieIcon.png")
            labelPuntuacion.text = "Avg: \(String(movieDetailCD.vote_average))"
            textfieldDescription.text = movieDetailCD.overview
        }
    }
    
    //MARK: Metodos del PlayerView
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .portrait
    }
    
    override var shouldAutorotate: Bool{
        return false
    }
    
    private func addPlayerView(){
        self.view.addSubview(playerView)
        playerView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: (self.view.bounds.height - 50))
    }
    
    func getYearSerie(fecha: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd"
        let date = dateFormatter.date(from: fecha)
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date!)
        
        return "\(year)"
    }
    
    func getYearMovie(fecha: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd"
        let date = dateFormatter.date(from: fecha)
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date!)
        
        return "\(year)"
    }

}
