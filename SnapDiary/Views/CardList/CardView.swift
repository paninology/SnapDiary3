//
//  CardView.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/05/31.
//

import UIKit

class CardView: BaseView {
    
    let centerView: UIView = {
       let view = UIView()
        view.backgroundColor = Constants.Color.background
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    let placeHolder: UILabel = {
       let view = UILabel()
        view.text = "일기를 위한 질문을 입력해주세요"
        view.textColor = .lightGray
//        view.backgroundColor = .blue
        return view
    }()
    
    let textView: UITextView = {
        let view = UITextView()
        view.backgroundColor = .clear
//        view.backgroundColor = .brown
        view.textAlignment = .center
//        let contentSize = view.contentSize
//        let topMargin = (view.bounds.height / 2) - (contentSize.height / 2)
//        view.contentInset = UIEdgeInsets(top: topMargin, left: 0, bottom: 0, right: 0)

     
        return view
    }()
 
    
    override func configure() {
        super.configure()
        [ centerView,placeHolder, textView, dismissButton, saveButton].forEach { addSubview($0)}
        backgroundColor = .clear
    }
    override func setConstraints() {
        super.setConstraints()
        centerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(44)
            make.top.equalToSuperview().offset(60)
            make.height.equalTo(centerView.snp.width).multipliedBy(1.7)
            //0.33:0.5
        }
        textView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(centerView.snp.horizontalEdges)
            make.top.equalTo(saveButton.snp.bottom)
            make.bottom.equalTo(centerView.snp.bottom)
        }
        dismissButton.snp.makeConstraints { make in
            make.top.equalTo(centerView.snp.top)
            make.leading.equalTo(centerView.snp.leading)
        }
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(centerView.snp.top)
            make.trailing.equalTo(centerView.snp.trailing)
        }
        placeHolder.snp.makeConstraints { make in
            make.center.equalTo(textView.snp.center)
        }
        
    }
}
