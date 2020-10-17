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
            Image(uiImage : imageStore.getImage(url: quiz.attachment?.url))
                .resizable()
                .frame(width: 75, height: 75)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 5)
            Text(quiz.question)
            Spacer()
            VStack{
                Text("Author").italic().font(.custom("tiny", size: 10)).frame(width: 40, height: 2)
                Image(uiImage : imageStore.getImage(url: quiz.author?.photo?.url))
                    .resizable()
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
            }
        }
    }
}

struct QuizRow_Previews: PreviewProvider {
    static var previews: some View {
        QuizRow(quiz: QuizModel.shared.quizzes[0])
    }
}
