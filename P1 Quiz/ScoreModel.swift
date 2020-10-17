//
//  ScoreModel.swift
//  P1 Quiz
//
//  Created by Yamil Mateo Rodriguez on 17/10/2020.
//

import Foundation

class ScoreModel:  ObservableObject {
    
    @Published var isCorrect: Bool = false
    @Published var alreadyScored: Set<Int> = []
    
    let quizModel = QuizModel.shared
    
    func check(answer: String, quiz: QuizItem){
        let formattedAnswer = answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        let formattedRightAnswer = quiz.answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        if formattedAnswer == formattedRightAnswer,
           !alreadyScored.contains(quiz.id) {
            alreadyScored.insert(quiz.id)
            isCorrect = true
        }else if formattedAnswer == formattedRightAnswer {
            isCorrect = true
        }else{
            isCorrect = false
        }
    }
}
