//
//  Diary.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/06/21.
//

import Foundation
import RealmSwift
//내용, 날짜, 날씨, 위치, 질문(카드)
final class Diary: Object {
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    @Persisted var text: String
    @Persisted var card: Card?
    @Persisted var date: Date
    
    convenience init(text: String, card: Card?, date: Date) {
        self.init()
        self.text = text
        self.card = card
        self.date = date
    }
}
