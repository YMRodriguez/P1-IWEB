//
//  ContentView.swift
//  P1 Quiz
//
//  Created by Yamil Mateo & Javier Ramos on 10/10/2020.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var quizModel: QuizModel
    @EnvironmentObject var scoreModel: ScoreModel
    
    @State var showAll: Bool = true
    
    var body: some View {
        
        NavigationView {
            List{
                Toggle(isOn: $showAll){
                    Label( "Ver todo" , systemImage: "list.bullet")
                }
                
                ForEach(quizModel.quizzes.indices, id: \.self){ i in
                    if showAll || !scoreModel.correct(quizModel.quizzes[i]){
                        /// label: {QuizRow()} esto sería lo equivalente sin sacar la closure fuera, sin corchetes no funcionaria.
                        NavigationLink( destination: QuizDetail(quiz: $quizModel.quizzes[i])){ QuizRow(quiz: $quizModel.quizzes[i])}
                        
                    }
                }
            }
            .navigationTitle("P1 Quiz")
            .navigationBarItems(trailing: Button(action: {quizModel.load()},
                                                 label: { Image(systemName: "arrow.clockwise")}))
            
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
        let quizModel = QuizModel()
        quizModel.loadExamples()
        return quizModel
    }()
    
    static var previews: some View {
        ContentView()
            .environmentObject(quizModel)
    }
}
