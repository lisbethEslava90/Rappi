//
//  Extensions.swift
//  WebScrapping
//
//  Created by Lisbeth Eslava on 11/27/18.
//  Copyright © 2018 PracticesLisbethEslava. All rights reserved.
//

import UIKit

extension UIImageView{
    
    func downloadedFrom(link: String, contenMode: UIView.ContentMode = .scaleAspectFit) {
        //guard intenta crear la variable, sino puede retorna
        guard let url = URL(string: link) else {return}
        downloadedFrom(url: url)
    }
    
    func downloadedFrom(url: URL, contenMode: UIView.ContentMode = .scaleAspectFit) {
        //sesion de descarga, para descargar un fichero desde la web
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                //si la respuesta es un html sin error (cod 200)
                let httpUrlResponse = response as? HTTPURLResponse, httpUrlResponse.statusCode == 200,
                //si el tipo de descarga tiene tipo image
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                //si los datos no son vacios y el error es nulo
                let data = data, error == nil,
                //se genera la imagen
                let image = UIImage(data: data)
            else { return }
            //de forma asincrona descarga la imagen
            DispatchQueue.main.async (){
                self.image = image
            }

        }.resume()
    }
    
    func downloadedFromUIImage(url: URL, contenMode: UIView.ContentMode = .scaleAspectFit) -> UIImage{
        //sesion de descarga, para descargar un fichero desde la web
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                //si la respuesta es un html sin error (cod 200)
                let httpUrlResponse = response as? HTTPURLResponse, httpUrlResponse.statusCode == 200,
                //si el tipo de descarga tiene tipo image
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                //si los datos no son vacios y el error es nulo
                let data = data, error == nil,
                //se genera la imagen
                let image = UIImage(data: data)
                else { return }
            
            //de forma asincrona descarga la imagen
            DispatchQueue.main.async (){
                self.image = image
            }
            
            }.resume()
        return self.image!
    }
}

