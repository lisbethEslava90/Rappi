//
//  PeliculaViewController.swift
//  TestRappi
//
//  Created by Lisbeth Eslava on 1/14/19.
//  Copyright © 2019 Lisbeth Eslava. All rights reserved.
//

import UIKit

class PeliculaViewController: UICollectionViewController {

  //  var fabrica : FabricaMovie!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    //    fabrica = FabricaMovie(urlAPI: "https://api.themoviedb.org/4/list/1")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10 //fabrica.movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celda = collectionView.dequeueReusableCell(withReuseIdentifier: "CeldaPelicula", for: indexPath) as! CeldaPelicula
        celda.TituloPelicula.text = "example"
       // celda.ImagePelicula.downloadedFrom(link: fabrica.canciones[indexPath.row].imageUrl)
        return celda
    }

}
