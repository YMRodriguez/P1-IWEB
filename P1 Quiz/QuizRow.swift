//
//  QuizRow.swift
//  P1 Quiz
//
//  Created by Yamil Mateo & Javier Ramos on 10/10/2020.
//

import SwiftUI

struct QuizRow: View {
    @EnvironmentObject var imageStore: ImageStore
    var quiz: QuizItem
    var body: some View {
        HStack{
            Image(uiImage: imageStore.image(url: quiz.attachment?.url))
                .resizable ()
                .frame(width: 50, height: 50) 
            Text(quiz.question)
            Spacer()
            VStack{
                Image(uiImage: imageStore.image(url: quiz.author?.photo?.url))
                    .resizable ()
                    .frame(width: 30, height: 30)
                Spacer() 
            }
        }
        
    }
}

struct QuizRow_Previews: PreviewProvider {
    static var previews: some View {
        QuizRow(quiz: QuizModel.shared.quizzes[0])
    }
}
