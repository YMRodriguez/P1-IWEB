//
//  QuizDetail.swift
//  P1 Quiz
//
//  Created by Yamil Mateo & Javier Ramos on 10/10/2020.
//

import SwiftUI

struct QuizDetail: View {
    var quiz: QuizItem
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @EnvironmentObject var scoreModel: ScoreModel
    @EnvironmentObject var imageStore: ImageStore
    
    @State var showAnswer: Bool = false
    @State var answer: String = ""
    @State var showAlert: Bool = false
    var body: some View {
        VStack{
            Text(quiz.question).font(.largeTitle)
            Text("Current score: \(scoreModel.alreadyScored.count)")
            TextField("Your answer...",
                      text: $answer,
                      onCommit: {
                        scoreModel.check(answer: answer, quiz: quiz)
                        showAlert = true
                      })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .shadow(radius: 10)
                .alert(isPresented: $showAlert, content: {
                    Alert(title: Text("Result"), message: Text(scoreModel.isCorrect ? "Right" : "Wrong"), dismissButton: .default(Text("OK")))
                })
            Group{
                if horizontalSizeClass == .regular{
                    HStack{
                        Button(action: { showAnswer = !showAnswer }, label: {
                            Text("Show solution")
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
                }else {
                    VStack{
                        Button(action: { showAnswer = !showAnswer }, label: {
                            Text("Show solution")
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
                }
                
            }
        }
        .padding()
    }
}

struct QuizDetail_Previews: PreviewProvider {
    static var previews: some View {
        QuizDetail(quiz: QuizModel.shared.quizzes[0])
    }
}
