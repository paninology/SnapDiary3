//
//  Deck.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/05/19.
//

import Foundation
import RealmSwift


final class Deck: Object {
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    @Persisted var title: String //제목(필수)
    @Persisted var questions: List<Card> //질문
    
    
    
    convenience init(title: String, questions: List<Card>) {
        self.init()
        self.title = title
        self.questions = questions
    }
}
