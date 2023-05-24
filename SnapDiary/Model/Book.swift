//
//  Book.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/05/19.
//

import Foundation
import RealmSwift


final class Book: Object {
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    @Persisted var title: String //제목(필수)
    @Persisted var deckID: ObjectId //덱 ID(필수) objectID 타입?? string?
    @Persisted var subtitle: String //
    
    
    
    convenience init(title: String, deckID: ObjectId, subtitle: String) {
        self.init()
        self.title = title
        self.deckID = deckID
        self.subtitle = subtitle
    }
}
