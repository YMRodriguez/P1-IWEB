//
//  ImageStore.swift
//  P1 Quiz SwiftUI
//
//  Created by Santiago Pavón Gómez on 28/09/2020.
//

import UIKit

class ImageStore: ObservableObject {
    
    // Cache para las imagenes.
    // La clave es un String con la url.
    /// Published para que la interfaz de usuario esté atenta por si en imagesCache cambia algo y se actualice automaticamente
    @Published var imagesCache = [URL:UIImage]()
    
    let defaultImage = UIImage(named: "default")!
    let fetchingImage = UIImage(named : "downloading")!
    let noImage = UIImage(named: "noImage")!
    
    // Si la imagen pedida esta en la cache, entonces la devuelve.
    // Si la imagen no esta en la cache entonces la descarga, y
    // actualizara la cache cuando la reciba.
    func getImage(url: URL?) -> UIImage {
        
        guard let url = url else {
            return defaultImage
        }
        
        if let img = imagesCache[url] {
            return img
        }
        
        /// En caso de que con la sentencia anterior la imagen no esté en la caché y se tenga que descargar
        imagesCache[url] = fetchingImage
        
        DispatchQueue.global().async {
            /// El segundo if solo se lleva a cabo tras el éxito del primero
            if let data = try? Data(contentsOf: url),
               let img = UIImage(data: data) {
                // DEBUG
                print(url)
                
                /// Esta queue conecta con el main principal de la apliación
                DispatchQueue.main.async {
                    /// En closure se necesita el self, tras guardar esto en la caché
                    self.imagesCache[url] = img
                }
            } else{
                /// DUDA: Pide .self 
                self.imagesCache[url] = self.noImage
            }
        }
        /// Esta sentencia se va a ejecutar sin que termine el dispatch anterior, es cuando termina que se actualiza el array de imagesCache y sus vistas debido a @Published
        return defaultImage
    }
}
