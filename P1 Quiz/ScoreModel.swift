//
//  ScoreModel.swift
//  P1 Quiz
//
//  Created by Javier Ramos on 14/10/2020.
//

import Foundation

class ScoreModel: ObservableObject {
        
    @Published var acertadas: Set<Int> = []
    func check(respuestas: String,quiz: QuizItem){
        
        let r1 = respuestas.lowercased().trimmingCharacters(in:.whitespacesAndNewlines)
        let r2 = quiz.answer.lowercased().trimmingCharacters(in:.whitespacesAndNewlines)   
        if r1 == r2,
           !acertadas.contains(quiz.id){
            acertadas.insert(quiz.id) 
        }
    }
}
