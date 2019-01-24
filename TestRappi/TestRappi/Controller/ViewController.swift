//
//  ViewController.swift
//  TestRappi
//
//  Created by Lisbeth Eslava on 1/10/19.
//  Copyright © 2019 Lisbeth Eslava. All rights reserved.
//
// Controlador de la vista inicial, se encarga de depurar la data (core data) si hay conexión a Internet.

import UIKit
import CoreData

class ViewController: UIViewController {
    var conexion = false
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        conexion = Connectivity.isConnectedToInternet
        if (conexion){
            let request : NSFetchRequest<MoviesCD> = MoviesCD.fetchRequest()
            
            if let result = try? context.fetch(request) {
                for object in result {
                    context.delete(object)
                }
            }
            
            do {
                try context.save()
            } catch {
                print("No se pudo guardar el borrado: \(error)")
            }
        }
    }


}

