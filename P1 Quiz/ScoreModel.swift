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
    init(){
        let us = UserDefaults.standard
        if let acertadas = us.object(forKey: "acertadas") as? Array<Int>{
            self.alreadyScored = Set(acertadas)
        }
    }

    
    func check(answer: String, quiz: QuizItem){
        let formattedAnswer = answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        let formattedRightAnswer = quiz.answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        if formattedAnswer == formattedRightAnswer,
           !alreadyScored.contains(quiz.id) {
            alreadyScored.insert(quiz.id)
            isCorrect = true
            let us = UserDefaults.standard
            us.set( Array<Int>(alreadyScored), forKey: "acertadas")
        }else if formattedAnswer == formattedRightAnswer {
            isCorrect = true
        }else{
            isCorrect = false
        }
    }
}
