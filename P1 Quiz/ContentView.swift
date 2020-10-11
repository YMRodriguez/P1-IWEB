//
//  ContentView.swift
//  P1 Quiz
//
//  Created by Yamil Mateo & Javier Ramos on 10/10/2020.
//

import SwiftUI

struct ContentView: View {
    
    /// Variable que instancia el modelo de datos en la View principal
    var model: QuizModel
    
    var body: some View {
        
        NavigationView {
            List{
                ForEach(model.quizzes, id: \.id){ quiz in
                    
                    /// label: {QuizRow()} esto sería lo equivalente sin sacar la closure fuera, sin corchetes no funcionaria.
                    // MARK: duda
                    NavigationLink( destination: QuizDetail(quiz: quiz)){ QuizRow(quiz: quiz)}
                }
            }
            .navigationTitle("P1 Quiz")
            
            Text("Selecciona una de las preguntas")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        /// Necesito crear esta variable dentro porque las previews son Static
        let model = QuizModel.shared
        
        Group {
            ContentView(model: model)
        }
    }
}
