//
//  QuizDetail.swift
//  P1 Quiz
//
//  Created by Yamil Mateo & Javier Ramos on 10/10/2020.
//

import SwiftUI

struct QuizDetail: View {
    var quiz: QuizItem
    @EnvironmentObject var imageStore: ImageStore
    
    var body: some View {
        VStack{
            Text(quiz.question).font(.largeTitle)
            
            Text("Answer: " + quiz.answer)
            
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
