//
//  QuizRow.swift
//  P1 Quiz
//
//  Created by Yamil Mateo & Javier Ramos on 10/10/2020.
//

import SwiftUI

struct QuizRow: View {
    var quiz: QuizItem
    var body: some View {
        Text(quiz.question)
    }
}

struct QuizRow_Previews: PreviewProvider {
    static var previews: some View {
        QuizRow(quiz: QuizModel.shared.quizzes[0])
    }
}
