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
struct QuizItem: Codable, Identifiable {
    let id: Int
    let question: String
    let answer: String
    let author: Author?
    let attachment: Attachment?
    var favourite: Bool
    
    struct Author: Codable {
        let isAdmin: Bool?
        let username: String?
        let accountTypeId: Int?
        let profileName: String?
        let photo: Attachment?
    }
    
    struct Attachment: Codable {
        let filename: String?
        let mime: String?
        let url: URL?
    }
}

/*
 Esta clase se encarga de procesar el JSON los quizzes, en este caso son siempre los mismos
 */
class QuizModel: ObservableObject {
    /// Extraidos del JSON, es fijo, si puedera modificarse en cualquier momento se va a querer la interfaz lo vigile, sería necesario un @Published
    @Published var quizzes = [QuizItem]()
    
    let session = URLSession.shared
    let urlBase = "https://core.dit.upm.es"
    let TOKEN = "a50c920a742a6a2f8771"
    
    func load() {
        
        let fetchQuizzesStringURL = "\(urlBase)/api/quizzes/random10wa?token=\(TOKEN)"
        
        guard let fetchQuizzesUrl = URL(string: fetchQuizzesStringURL) else {
            print("Fallo creando URL")
            return
        }
        
        let task = session.dataTask(with: fetchQuizzesUrl) { (data, res, error) in
            if error != nil {
                print("Fallo en Task")
                return
            }
            if (res as! HTTPURLResponse).statusCode != 200 {
                print("Fallo en res")
                return
            }
            let decoder = JSONDecoder()
            
            // let str = String(data: data, encoding: String.Encoding.utf8)
            // print("Quizzes ==>", str!)
            if let quizzes = try? decoder.decode([QuizItem].self, from: data!) {
                DispatchQueue.main.async {
                    self.quizzes = quizzes
                }
            }
        }
        
        task.resume()
        
    }
    
    /*
     Este metodo va a cambiar el campo favorito del quiz que se le pase como parametro
     */
    func toggleFavourite( _ quizItem: QuizItem){
        
        guard let index = quizzes.firstIndex(where: {$0.id == quizItem.id}) else {
            print("Fallo 5")
            return
        }
        
        let favouriteURL = "\(urlBase)/api/users/tokenOwner/favourites/\(quizItem.id)?token=\(TOKEN)"
        
        guard let fetchFavouritesQuizzesUrl = URL(string: favouriteURL) else {
            print("Fallo creando URL2")
            return
        }
        
        var request = URLRequest(url: fetchFavouritesQuizzesUrl)
        request.httpMethod = quizItem.favourite ? "DELETE":"PUT"
        request.addValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
        
        let task = session.uploadTask(with: request, from: Data()) { (data, res, error) in
            if error != nil {
                print("Fallo en Task")
                return
            }
            if (res as! HTTPURLResponse).statusCode != 200 {
                print("Fallo en res")
                return
            }
            
            DispatchQueue.main.async {
                self.quizzes[index].favourite.toggle()
            }
        }
        task.resume()
    }
    
    
    func loadExamples() {
        quizzes = [
            QuizItem(id:1,
                     question: "una y una",
                     answer:"dos",
                     author: nil,
                     attachment: nil,
                     favourite: true
            ),
            QuizItem(id:2,
                     question: "dos por dos",
                     answer:"cuatro",
                     author: nil,
                     attachment: nil,
                     favourite: true)
        ]
    }
}

