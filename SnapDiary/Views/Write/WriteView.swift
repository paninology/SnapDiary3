//
//  WriteView.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/05/24.
//

import UIKit

//날짜(모달팝업),질문,질문변경,질문카드 추가, 답변,사진등록(1장)
final class WriteView: BaseView {
    
    let questionLable: UILabel = {
        let view = UILabel()
        view.text = "오늘 아침 메뉴는?"
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
