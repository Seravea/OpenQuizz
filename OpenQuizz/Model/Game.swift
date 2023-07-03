//
//  Game.swift
//  OpenQuizz
//
//  Created by Romain Poyard on 30/06/2023.
//

import Foundation


class Game {



var score: Int = 0
var questions: [Question] = []
var state: State = .ongoing
private var currentIndex: Int = 0
var currentQuestion: Question {
  return questions[currentIndex]
}

enum State {
  case ongoing
  case over
}

func answerCurrentQuestion(with answer: Bool) {
  if currentIndex <= questions.count - 1 {
      if (currentQuestion.isCorrect && answer) || (!currentQuestion.isCorrect && answer) {
    score += 1
    currentIndex += 1
  } else {
currentIndex += 1
  }
} else {
    state = .over
  }
    
}
    private func goToNextQuestion() {
        if currentIndex < questions.count - 1 {
            currentIndex += 1
        }else {
            finishGame()
        }
    }
    private func finishGame() {
        if currentIndex == questions.count - 1 {
            state = .over
        }
    }
    
    func refresh() {
        score = 0
        currentIndex = 0
        state = .over
        
        QuestionManager.shared.get { (questions) in
            
            self.questions = questions
            
            self.state = .ongoing
        }
        let name = Notification.Name(rawValue: "QuestionsLoaded")
        let notification = Notification(name: name)
        NotificationCenter.default.post(notification)
        
        
    }
    
    
    
    
}
