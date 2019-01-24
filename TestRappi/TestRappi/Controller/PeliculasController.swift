//
//  PelicularController.swift
//  TestRappi
//
//  Created by Lisbeth Eslava on 1/17/19.
//  Copyright © 2019 Lisbeth Eslava. All rights reserved.
//
// Controlador asiganado a la vista de peliculas.

import UIKit
import CoreData

class PeliculasController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var controllerMoviesPO: UICollectionView!
    
    @IBOutlet weak var controllerMoviesTR: UICollectionView!
    
    @IBOutlet weak var controllerMoviesUP: UICollectionView!
    
    @IBOutlet weak var searchBarMovie: UISearchBar!
    
    var imagenMovieDefault = UIImageView(image: UIImage(named: "movieFondo.png"))
    
    var saveImage : UIImage!
    
    var collectionSelected = ""
    
    var fabrica = FabricaMovie(tipo: 1)
    
    var selected = -1
    
    var moviesArray = [MoviesCD]()
    var moviesArrayUP = [MoviesCD]()
    var moviesArrayTR = [MoviesCD]()
    var moviesArrayPO = [MoviesCD]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var conexion = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        conexion = Connectivity.isConnectedToInternet
        
        if (conexion){
            self.searchBarMovie.isHidden = true
            NotificationCenter.default.addObserver(self, selector: #selector(updateCollection), name: NSNotification.Name("MovieUpdate"), object: nil)
        }else{
            self.leerCoreData()
        }
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(conexion){
            if(collectionView == controllerMoviesPO){
                return fabrica.getLengthMoviesPO()
            }
            if(collectionView == controllerMoviesTR){
                return fabrica.getLengthMoviesTR()
            }
            if(collectionView == controllerMoviesUP){
                return fabrica.getLengthMoviesUP()
            }
            else{
                return 1
            }
        }else{
            if(collectionView == controllerMoviesPO){
                return moviesArrayPO.count
            }
            if(collectionView == controllerMoviesTR){
                return moviesArrayTR.count
            }
            if(collectionView == controllerMoviesUP){
                return moviesArrayUP.count
            }
            else{
                return 1
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let celda = collectionView.dequeueReusableCell(withReuseIdentifier: "CeldaSerie", for: indexPath) as! CeldaSerie
        
        if (conexion){
            if(collectionView == controllerMoviesPO){
                celda.tituloSerie.text = fabrica.moviesPO.movies![indexPath.row].title
                celda.imageSerie.downloadedFrom(link: fabrica.moviesPO.movies![indexPath.row].getUrlImage(jpg: fabrica.moviesPO.movies![indexPath.row].poster_path!))
            }
            
            if(collectionView == controllerMoviesTR){
                celda.tituloSerie.text = fabrica.moviesTR.movies![indexPath.row].title
                celda.imageSerie.downloadedFrom(link: fabrica.moviesTR.movies![indexPath.row].getUrlImage(jpg: fabrica.moviesTR.movies![indexPath.row].poster_path!))
            }
            
            if(collectionView == controllerMoviesUP){
                celda.tituloSerie.text = fabrica.moviesUP.movies![indexPath.row].title
                celda.imageSerie.downloadedFrom(link: fabrica.moviesUP.movies![indexPath.row].getUrlImage(jpg: fabrica.moviesUP.movies![indexPath.row].poster_path!))
            }
        }else{
            if(collectionView == controllerMoviesPO){
                celda.tituloSerie.text = moviesArrayPO[indexPath.row].title
                celda.imageSerie.image = UIImage(named: "movieIcon.png")
            }
            
            if(collectionView == controllerMoviesTR){
                celda.tituloSerie.text = moviesArrayTR[indexPath.row].title
                celda.imageSerie.image = UIImage(named: "movieIcon.png")
            }
            
            if(collectionView == controllerMoviesUP){
                celda.tituloSerie.text = moviesArrayUP[indexPath.row].title
                celda.imageSerie.image = UIImage(named: "movieIcon.png")
            }
        }

        return celda
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == controllerMoviesPO {
            collectionSelected = "collectionMoviesPO"
        }
        if collectionView == controllerMoviesTR {
            collectionSelected = "collectionMoviesTR"
        }
        if collectionView == controllerMoviesUP {
            collectionSelected = "collectionMoviesUP"
        }
        selected = indexPath.row
        performSegue(withIdentifier: "ShowDetailMovie", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ShowDetailMovie"){
            let destinationVC = segue.destination as! DetalleController
            destinationVC.tipo = 1
            
            if(conexion){
                if collectionSelected == "collectionMoviesPO"{
                    destinationVC.movieDetail = fabrica.moviesPO.movies![selected]
                }else if(collectionSelected == "collectionMoviesTR"){
                    destinationVC.movieDetail = fabrica.moviesTR.movies![selected]
                }else if(collectionSelected == "collectionMoviesUP"){
                    destinationVC.movieDetail = fabrica.moviesUP.movies![selected]
                }
            }else{
                if collectionSelected == "collectionMoviesPO"{
                    destinationVC.movieDetailCD = moviesArrayPO[selected]
                }else if(collectionSelected == "collectionMoviesTR"){
                    destinationVC.movieDetailCD = moviesArrayTR[selected]
                }else if(collectionSelected == "collectionMoviesUP"){
                    destinationVC.movieDetailCD = moviesArrayUP[selected]
                }
            }
        }
    }
    
    @objc func updateCollection(){
        self.controllerMoviesUP.reloadData()
        self.controllerMoviesPO.reloadData()
        self.controllerMoviesTR.reloadData()
        
        if fabrica.getLengthMoviesPO() > 0 && fabrica.getLengthMoviesUP() > 0 && fabrica.getLengthMoviesTR() > 0{
            self.loadCoreData()
        }
        
    }
    
    func loadCoreData(){
        
        self.moviesArray.removeAll()
        loadCoreDataArrays(objectMovie: fabrica.moviesPO, categoria: "PO")
        loadCoreDataArrays(objectMovie: fabrica.moviesTR, categoria: "TR")
        loadCoreDataArrays(objectMovie: fabrica.moviesUP, categoria: "UP")
  
    }
    
    func loadCoreDataArrays(objectMovie: Movies, categoria: String){
        for items in objectMovie.movies!{
            let moviesCD = MoviesCD(context: self.context)
            moviesCD.tipo = 1
            moviesCD.categoria = categoria
            moviesCD.title = items.title
            moviesCD.overview = items.overview
            moviesCD.poster_path = items.poster_path
            moviesCD.vote_average = items.vote_average!
            moviesCD.release_date = items.release_date
            moviesCD.image = items.getImagen().pngData()
            self.moviesArray.append(moviesCD)
        }
        self.persistMovies()
    }
    
    func persistMovies(){
        do {
            try context.save()
        } catch {
            print("Error al intentar guardar el contexto: \(error)")
        }
    }
    
    func leerCoreData(predicate: NSPredicate? = nil){
        
        let requestUP : NSFetchRequest<MoviesCD> = MoviesCD.fetchRequest()
        let requestTR : NSFetchRequest<MoviesCD> = MoviesCD.fetchRequest()
        let requestPO : NSFetchRequest<MoviesCD> = MoviesCD.fetchRequest()
        
        let predicateUP = NSPredicate(format: "tipo == 1 AND categoria == 'UP' ")
        let predicateTR = NSPredicate(format: "tipo == 1 AND categoria == 'TR' ")
        let predicatePO = NSPredicate(format: "tipo == 1 AND categoria == 'PO' ")
        
        if let previousPredicate = predicate{
            let compoundPredicateUP = NSCompoundPredicate(andPredicateWithSubpredicates: [previousPredicate, predicateUP])
            let compoundPredicateTR = NSCompoundPredicate(andPredicateWithSubpredicates: [previousPredicate, predicateTR])
            let compoundPredicatePO = NSCompoundPredicate(andPredicateWithSubpredicates: [previousPredicate, predicatePO])
            requestUP.predicate = compoundPredicateUP
            requestTR.predicate = compoundPredicateTR
            requestPO.predicate = compoundPredicatePO
        }else{
            requestUP.predicate = predicateUP
            requestTR.predicate = predicateTR
            requestPO.predicate = predicatePO
        }
     
        do {
            try moviesArrayUP = context.fetch(requestUP)
            try moviesArrayTR = context.fetch(requestTR)
            try moviesArrayPO = context.fetch(requestPO)
            
        } catch {
            print("Error recuperando movies: \(error)")
        }
        controllerMoviesPO.reloadData()
        controllerMoviesTR.reloadData()
        controllerMoviesUP.reloadData()
    }
    
}

//MARK: Metodos de las UISearchBar
extension PeliculasController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let searchText = searchBar.text!
        
        let request : NSFetchRequest<MoviesCD> = MoviesCD.fetchRequest()
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sortDescriptor]

        leerCoreData(predicate: predicate)
        
        DispatchQueue.main.async {
            searchBar.resignFirstResponder()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            leerCoreData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
    }
    
}
