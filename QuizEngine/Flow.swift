//
//  Created by Apit Gilang Aprida on 17/02/22.
//

import Foundation

protocol Router {
    func routeTo(question: String, answerCallback: @escaping (String) -> Void)
}

class Flow {
    let router: Router
    let questions: [String]

    init(questions: [String], router: Router) {
        self.router = router
        self.questions = questions
    }

    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion) { [weak self] _ in
                guard let self = self else { return }
                let firstQuestionIndex = self.questions.firstIndex(of: firstQuestion)!
                let nextQuestion = self.questions[firstQuestionIndex + 1]
                self.router.routeTo(question: nextQuestion, answerCallback: { _ in })
            }
        }
    }
}
