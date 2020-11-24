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
    @Published private(set) var quizzes = [QuizItem]()
    
    /// El constructor es privado ya que no se quiere que se puedan crear instancias desde otras clases
    
    let session = URLSession.shared
    let urlBase = "https://core.dit.upm.es"
    let TOKEN = "683bf75fd3e6f3a4b1d8"
    func load() {
        let s = "\(urlBase)/api/quizzes/random10wa?token=\(TOKEN)"
        guard let url = URL(string: s) else{
            print("fallo en la URL")
            return
        }
        let t = session.dataTask(with: url) { (data, res, error) in
            if error != nil{
                print("fallo")
                return
            }
            if(res as! HTTPURLResponse).statusCode != 200{
                print("fallo")
                return
            }
            let decoder = JSONDecoder()
            
            // let str = String(data: data, encoding: String.Encoding.utf8)
            // print("Quizzes ==>", str!)
            
            if let quizzes = try? decoder.decode([QuizItem].self, from: data!){
            DispatchQueue.main.async {
                self.quizzes = quizzes
                
            }
            }
        }
        t.resume()
    }
    
    func toggleFavourite(_ quizItem : QuizItem){
        guard let index = quizzes.firstIndex(where:{$0.id == quizItem.id}) else{
            print("fallo2")
            return
        }
        let surl = "\(urlBase)/api/users/tokenOwner/favourites/\(quizItem.id)?token=\(TOKEN)"
        guard let url = URL(string: surl) else{
            print("fallo1")
            return
        }
        var  request = URLRequest(url: url)
        request.httpMethod = quizItem.favourite ? "DELETE" : "PUT"
        request.addValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
        
        let t = session.uploadTask(with: request, from: Data()){(data, res , error) in
                
                if error != nil{
                    print("fallo3")
                    return
                }
                if(res as! HTTPURLResponse).statusCode != 200{
                    print((res as! HTTPURLResponse).statusCode)
                    return
                }
                DispatchQueue.main.async {
                    self.quizzes[index].favourite.toggle()
                }
                
        }
            t.resume()
    }
    
    func loadExamples(){
        quizzes = [
            QuizItem(id:1,
            question: "fjeofbr",
            answer:"cdjfbewu",
            author: nil,
            attachment: nil,
            favourite: true
            )
        ]
    }
}

