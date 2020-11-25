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
        // No se pueden meter conjuntos en el userDefault
        if let alreadyScored = UserDefaults.standard.object(forKey: "alreadyScored") as? Array<Int> {
            // Pero aqui lo que quiero si es un conjunto
            self.alreadyScored = Set(alreadyScored)
        }
        
        
    }
    func check(answer: String, quiz: QuizItem){
        let formattedAnswer = answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        let formattedRightAnswer = quiz.answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        if formattedAnswer == formattedRightAnswer,
           !alreadyScored.contains(quiz.id) {
            
            alreadyScored.insert(quiz.id)
            isCorrect = true
            
            UserDefaults.standard.set(Array<Int>(alreadyScored), forKey: "alreadyScored")
        }else if formattedAnswer == formattedRightAnswer {
            isCorrect = true
        }else{
            isCorrect = false
        }
    }
    
    func correct(_ quiz: QuizItem) -> Bool {
        alreadyScored.contains(quiz.id)
    }
    
    func clean() {
        alreadyScored.removeAll()
        
        UserDefaults.standard
            .set(Array<Int>(alreadyScored), forKey: "alreadyScored")
    }
}
