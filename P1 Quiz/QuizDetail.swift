//
//  QuizDetail.swift
//  P1 Quiz
//
//  Created by Yamil Mateo & Javier Ramos on 10/10/2020.
//

import SwiftUI

struct QuizDetail: View {
    var quiz: QuizItem
    
    //@ObservableObject var scoreModel: ScoreModel
    @EnvironmentObject var imageStore: ImageStore
    
    @State var showAnswer: Bool = false
    @State private var answer: String = ""
    
    var body: some View {
        VStack{
            Text(quiz.question).font(.largeTitle)
            
            TextField("Su respuesta...",
                      text: $answer,
                      onCommit: {
                        if answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == quiz.answer.lowercased(){
                            
                        }
                      })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .shadow(radius: 10)
             
                Button(action: { showAnswer = !showAnswer }, label: {
                    Text("Mostrar solución")
                        .fontWeight(.bold)
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                        .shadow(radius: 1)
                })
                if (showAnswer){
                    Text("Answer: " + quiz.answer)
                }
            
            
            Image(uiImage: imageStore.getImage(url: quiz.attachment?.url))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 15)
                .animation(.easeInOut)
        }
        .padding()
    }
}

struct QuizDetail_Previews: PreviewProvider {
    static var previews: some View {
        QuizDetail(quiz: QuizModel.shared.quizzes[0])
    }
}
