//
//  QuizDetail.swift
//  P1 Quiz
//
//  Created by Yamil Mateo & Javier Ramos on 10/10/2020.
//

import SwiftUI

struct QuizDetail: View {
    @Binding var quiz: QuizItem
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @EnvironmentObject var scoreModel: ScoreModel
    @EnvironmentObject var imageStore: ImageStore
    @EnvironmentObject var quizModel: QuizModel

    
    @State var showAnswer: Bool = false
    @State var answer: String = ""
    @State var showAlert: Bool = false
    
    var body: some View {
        VStack{
            Group{
                if horizontalSizeClass == .regular{
                    VStack{
                        HStack{
                            Text(quiz.question).font(.largeTitle)
                            Spacer()
                            Text("Author: \(quiz.author?.username ?? "unknown")").italic().font(.custom("tiny", size: 10))
                            Image(uiImage : imageStore.getImage(url: quiz.author?.photo?.url))
                                .resizable()
                                .frame(width: 30, height: 30)
                                .clipShape(Circle())
                            
                        }
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
                        HStack{
                            VStack{
                                Text("Current score: \(scoreModel.alreadyScored.count)")
                                Button(action: {
                                    self.quizModel.toggleFavourite(quiz)
                                }){
                                    Image(quiz.favourite ? "yellow-star":"blank-star")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .scaledToFit()
                                }
                            }
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
                }else {
                    VStack{
                        Text(quiz.question).font(.largeTitle)
                        HStack{
                            Text("Author: \(quiz.author?.username ?? "unknown")").italic().font(.custom("tiny", size: 10))
                            Image(uiImage : imageStore.getImage(url: quiz.author?.photo?.url))
                                .resizable()
                                .frame(width: 30, height: 30)
                                .clipShape(Circle())
                            Button(action: {
                                self.quizModel.toggleFavourite(quiz)
                            }){
                                Image(quiz.favourite ? "yellow-star":"blank-star")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .scaledToFit()
                            }
                        }
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
    static let quizModel: QuizModel = {
        let quizModel = QuizModel()
        quizModel.loadExamples()
        return quizModel
    }()
    static var previews: some View {
        EmptyView()
        //QuizDetail(quiz: quizModel.quizzes[0])
    }
}
