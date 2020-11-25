//
//  P1_QuizApp.swift
//  P1 Quiz
//
//  Created by Yamil Mateo & Javier Ramos on 10/10/2020.
//

import SwiftUI

@main
struct P1_QuizApp: App {
    
    let quizModel: QuizModel = {
        let quizModelInstance = QuizModel()
        quizModelInstance.load()
        return quizModelInstance
    }()
    
    let imageStore = ImageStore()
    let scoreModel = ScoreModel()
    
    var body: some Scene {
        WindowGroup {
            /// Recibe el modelo que tiene que pintar, a diferencia de en el ContentView, no tengo que crear la variable que contiene la instancia al modelo dentro ya que WindowGroup no es Static
            ContentView()
                .environmentObject(quizModel)
                .environmentObject(imageStore)
                .environmentObject(scoreModel)
        }
    }
}
