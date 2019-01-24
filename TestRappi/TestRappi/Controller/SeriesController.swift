//
//  SeriesController.swift
//  TestRappi
//
//  Created by Lisbeth Eslava on 1/14/19.
//  Copyright © 2019 Lisbeth Eslava. All rights reserved.
//
// Controlador asignado a la vista de Series.

import UIKit
import  CoreData

class SeriesController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionSeriesPO: UICollectionView!
    
    @IBOutlet weak var collectionSeriesTR: UICollectionView!
    
    @IBOutlet weak var searchBarSeries: UISearchBar!
    
    var fabrica = FabricaMovie(tipo: 2)
    
    var selected = -1
    
    var collectionSelected = ""
    
    var conexion = false
    
    var seriesArray = [MoviesCD]()
    var seriesArrayTR = [MoviesCD]()
    var seriesArrayPO = [MoviesCD]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
 
        super.viewDidLoad()
        
        conexion = Connectivity.isConnectedToInternet
        
        //Si hay conexion a internet se activa el escuchador para recargar la data de las series que retorna la API
        if(conexion){
            self.searchBarSeries.isHidden = true
            NotificationCenter.default.addObserver(self, selector: #selector(updateCollection), name: NSNotification.Name("MovieUpdate"), object: nil)
        }else{
            //Si no hay conexion a internet se carga la data almacenada
            self.leerCoreDataSeries()
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(conexion){
            if(collectionView == collectionSeriesPO){
                return fabrica.getLengthSeriesPO()
            }
            if(collectionView == collectionSeriesTR){
                return fabrica.getLengthSeriesTR()
            }
            else{
                return 1
            }
        }else{
            if(collectionView == collectionSeriesPO){
                return seriesArrayPO.count
            }
            if(collectionView == collectionSeriesTR){
                return seriesArrayTR.count
            }
            else{
                return 1
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celda = collectionView.dequeueReusableCell(withReuseIdentifier: "CeldaSerie", for: indexPath) as! CeldaSerie
        
        if(conexion){
            if(collectionView == collectionSeriesPO){
                collectionSelected = "collectionSeriesPO"
                celda.tituloSerie.text = fabrica.seriesPO.movies![indexPath.row].name
                celda.imageSerie.downloadedFrom(link: fabrica.seriesPO.movies![indexPath.row].getUrlImage(jpg: fabrica.seriesPO.movies![indexPath.row].poster_path!))
            }
            if(collectionView == collectionSeriesTR){
                collectionSelected = "collectionSeriesTR"
                celda.tituloSerie.text = fabrica.seriesTR.movies![indexPath.row].name
                celda.imageSerie.downloadedFrom(link: fabrica.seriesTR.movies![indexPath.row].getUrlImage(jpg: fabrica.seriesTR.movies![indexPath.row].poster_path!))
            }
        }else{
            if(collectionView == collectionSeriesPO){
                collectionSelected = "collectionSeriesPO"
                celda.tituloSerie.text = seriesArrayPO[indexPath.row].title
                celda.imageSerie.image = UIImage(named: "movieIcon.png")
            }
            
            if(collectionView == collectionSeriesTR){
                collectionSelected = "collectionSeriesTR"
                celda.tituloSerie.text = seriesArrayTR[indexPath.row].title
                celda.imageSerie.image = UIImage(named: "movieIcon.png")
            }
        }
        return celda
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionSeriesPO {
            collectionSelected = "collectionSeriesPO"
        }
        if collectionView == collectionSeriesTR {
            collectionSelected = "collectionSeriesTR"
        }
        selected = indexPath.row
        performSegue(withIdentifier: "ShowDetailSeries", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ShowDetailSeries"){
            let destinationVC = segue.destination as! DetalleController
            destinationVC.tipo = 2
            
            if(conexion){
                if collectionSelected == "collectionSeriesPO"{
                    destinationVC.movieDetail = fabrica.seriesPO.movies![selected]
                }else if(collectionSelected == "collectionSeriesTR"){
                    destinationVC.movieDetail = fabrica.seriesTR.movies![selected]
                }
            }else{
                if collectionSelected == "collectionSeriesPO"{
                    destinationVC.movieDetailCD = seriesArrayPO[selected]
                }else if(collectionSelected == "collectionSeriesTR"){
                    destinationVC.movieDetailCD = seriesArrayTR[selected]
                }
            }
        }
    }

    @objc func updateCollection(){
        self.collectionSeriesPO.reloadData()
        self.collectionSeriesTR.reloadData()
        
        //Si la API retorna informacion y se encuentra almacenada en los arrays se procede a cargarla en CoreData
        if fabrica.getLengthSeriesPO() > 0 && fabrica.getLengthSeriesTR() > 0{
            self.loadCoreData()
        }
    }
    
    func loadCoreData(){
        self.seriesArray.removeAll()
        loadCoreDataArrays(objectMovie: fabrica.seriesPO, categoria: "PO")
        loadCoreDataArrays(objectMovie: fabrica.seriesTR, categoria: "TR")
        
    }
    
    func loadCoreDataArrays(objectMovie: Movies, categoria: String){
        for items in objectMovie.movies!{
            let moviesCD = MoviesCD(context: self.context)
            moviesCD.tipo = 2
            moviesCD.categoria = categoria
            moviesCD.title = items.name
            moviesCD.overview = items.overview
            moviesCD.poster_path = items.poster_path
            moviesCD.vote_average = items.vote_average!
            moviesCD.release_date = items.first_air_date
            self.seriesArray.append(moviesCD)
        }
        self.persistMovies()
    }
    
    func persistMovies(){
        //persistencia de datos con CoreData
        do {
            try context.save()
        } catch {
            print("Error al intentar guardar el contexto: \(error)")
        }
    }
    
    func leerCoreDataSeries(predicate: NSPredicate? = nil){

        let requestTR : NSFetchRequest<MoviesCD> = MoviesCD.fetchRequest()
        let requestPO : NSFetchRequest<MoviesCD> = MoviesCD.fetchRequest()
        
        let predicateTR = NSPredicate(format: "tipo == 2 AND categoria == 'TR' ")
        let predicatePO = NSPredicate(format: "tipo == 2 AND categoria == 'PO' ")
        
        if let previousPredicate = predicate{
            let compoundPredicateTR = NSCompoundPredicate(andPredicateWithSubpredicates: [previousPredicate, predicateTR])
            let compoundPredicatePO = NSCompoundPredicate(andPredicateWithSubpredicates: [previousPredicate, predicatePO])
            requestTR.predicate = compoundPredicateTR
            requestPO.predicate = compoundPredicatePO
        }else{
            requestTR.predicate = predicateTR
            requestPO.predicate = predicatePO
        }
        
        do {
            try seriesArrayTR = context.fetch(requestTR)
            try seriesArrayPO = context.fetch(requestPO)
            
        } catch {
            print("Error recuperando movies: \(error)")
        }
        collectionSeriesPO.reloadData()
        collectionSeriesTR.reloadData()
    }
}
//MARK: Metodos de las UISearchBar
extension SeriesController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let searchText = searchBar.text!
        let request : NSFetchRequest<MoviesCD> = MoviesCD.fetchRequest()
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        leerCoreDataSeries(predicate: predicate)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            leerCoreDataSeries()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
    }
    
}
