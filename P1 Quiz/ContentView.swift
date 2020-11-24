//
//  ContentView.swift
//  P1 Quiz
//
//  Created by Yamil Mateo & Javier Ramos on 10/10/2020.
//

import SwiftUI

struct ContentView: View {
    @State var showAll: Bool = true
    @EnvironmentObject var quizModel: QuizModel
    @EnvironmentObject var scoreModel: ScoreModel
    
    var body: some View {
        
        NavigationView {
            List{
                Toggle(isOn: $showAll){
                    Label("ver todo", systemImage: "list.bullet")
                }
                ForEach(quizModel.quizzes, id: \.id){ quiz in
                    if showAll || !scoreModel.acertado(quiz){
                        NavigationLink( destination: QuizDetail(quiz:quiz)){ QuizRow(quiz: quiz)}
                    }
                    /// label: {QuizRow()} esto sería lo equivalente sin sacar la closure fuera, sin corchetes no funcionaria.
                    // MARK: duda
                    
                }
            }
            .navigationTitle("P1 Quiz")
            
            HStack{
                Image("UpLeft")
                    .resizable()
                    .scaledToFit()
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 20)
                
                Text("Selecciona una de las preguntas donde señala la flecha")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let quizModel: QuizModel = {
        let qm = QuizModel()
        qm.loadExamples()
        return qm
    }()
    
    static var previews: some View {
        /// Necesito crear esta variable dentro porque las previews son Static
            ContentView()
                .environmentObject(quizModel)
    }
}
