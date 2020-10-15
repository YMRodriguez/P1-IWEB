//
//  QuizDetail.swift
//  P1 Quiz
//
//  Created by Yamil Mateo & Javier Ramos on 10/10/2020.
//

import SwiftUI

struct QuizDetail: View {
    var quiz: QuizItem
    @State var respuesta : String = ""
    @State var muestraAlerta : Bool = false
    @EnvironmentObject var imageStore: ImageStore
    @EnvironmentObject var scoreModel: ScoreModel
    @State var showAnswer: Bool = false

    var body: some View {
        VStack{
            Text("tus puntos son \(scoreModel.acertadas.count)")
                .font(.largeTitle)
            Text(quiz.question).font(.largeTitle)
            TextField("Teclee la respuesta", 
                      text: $respuesta, 
                      onEditingChanged: {b in },
                      onCommit:{
                        scoreModel.check(respuestas: respuesta, quiz:  quiz  )
                        muestraAlerta = true
                      } )
                .alert(isPresented: $muestraAlerta){
                    let r1 = respuesta.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
                    let r2 = quiz.answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    return Alert(title: Text("resultado"),
                                 message: Text(r1==r2 ? "correcto": "mal" ),
                          dismissButton: .default(Text("OK" ))
)                }
            Button(action: { showAnswer = !showAnswer }, label: {
                Text("Mostrar respuesta")
            })
            if (showAnswer){
                Text("Answer: " + quiz.answer)
            }
            Image(uiImage: imageStore.image(url: quiz.attachment?.url))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 20)
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
