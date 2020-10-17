//
//  QuizModel.swift
//  P1 Quiz SwiftUI
//
//  Created by Santiago Pavón Gómez on 28/09/2020.
//

import Foundation

/*
 Esta struct mapea el JSON con los quizzes
 */
struct QuizItem: Codable {
    let id: Int
    let question: String
    let answer: String
    let author: Author?
    let attachment: Attachment?
    let favourite: Bool
    
    struct Author: Codable {
        let isAdmin: Bool?
        let username: String
        let photo: Attachment?
    }
    
    struct Attachment: Codable {
        let filename: String
        let mime: String
        let url: URL?
    }
}

/*
 Esta clase se encarga de procesar el JSON los quizzes, en este caso son siempre los mismos
 */
class QuizModel {
    /// Solución al constructor privado, patrón Singleton para crear la primera instancia. El static permite que todo el mundo comparta una única instancia de dicha clase
    private(set) static var shared = QuizModel()
    
    /// Extraidos del JSON, es fijo, si puedera modificarse en cualquier momento se va a querer la interfaz lo vigile, sería necesario un @Published
    private(set) var quizzes = [QuizItem]()
    
    /// El constructor es privado ya que no se quiere que se puedan crear instancias desde otras clases
    private init() {
       load()
    }
    
    private func load() {
        
        guard let jsonURL = Bundle.main.url(forResource: "p1_quizzes", withExtension: "json") else {
            print("Internal error: No encuentro p1_quizzes.json")
            return
        }
        
        do {
            let data = try Data(contentsOf: jsonURL)
            let decoder = JSONDecoder()
            
            // let str = String(data: data, encoding: String.Encoding.utf8)
            // print("Quizzes ==>", str!)
            
            let quizzes = try decoder.decode([QuizItem].self, from: data)
            self.quizzes = quizzes
        } catch {
            print("Algo chungo ha pasado: \(error)")
        }
    }
}

