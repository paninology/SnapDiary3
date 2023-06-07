//
//  Card.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/05/24.
//

import Foundation
import RealmSwift
//전체 카드 테이블
final class Card: Object {
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    @Persisted var question: String//질문
    
    convenience init(question: String) {
        self.init()
        self.question = question
    }
}
