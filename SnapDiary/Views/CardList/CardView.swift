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
        view.backgroundColor = .blue
        return view
    }()
    
    let textView: UITextView = {
        let view = UITextView()
//        view.backgroundColor = .clear
        view.backgroundColor = .brown
        view.textAlignment = .center
//        view.centerVertically()
        view.textContainerInset = UIEdgeInsets(top: 70, left: 20, bottom: 20, right: 20) 
     
        return view
    }()
    
//    let dismissButton: UIButton = {
//        let view = UIButton(type: .close)
//        return view
//    }()
//    
//    let saveButton: UIButton = {
//        let view = UIButton()
//        view.setTitle("저장", for: .normal)
//        return view
//    }()
    
    override func configure() {
        super.configure()
        [ centerView,placeHolder, textView, dismissButton, saveButton].forEach { addSubview($0)}
//        [ centerView, textView, dismissButton, saveButton].forEach { addSubview($0)}
        backgroundColor = .clear
    }
    override func setConstraints() {
        super.setConstraints()
        centerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(44)
            make.center.equalToSuperview()
            make.height.equalTo(centerView.snp.width).multipliedBy(1.5)
            //0.33:0.5
        }
        textView.snp.makeConstraints { make in
            make.edges.equalTo(centerView.snp.edges)
//            make.center.equalToSuperview()
//            make.height.greaterThanOrEqualTo(44)
            make.horizontalEdges.equalTo(centerView.snp.horizontalEdges)
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

extension UITextView {

    func centerVerticalText() {
        self.textAlignment = .center
        let fitSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fitSize)
        let calculate = (bounds.size.height - size.height * zoomScale) / 2
        let offset = max(1, calculate)
        contentOffset.y = -offset
    }

     func centerVertically()
    {
        let iFont = font == nil ? UIFont.systemFont(ofSize: UIFont.systemFontSize) : font!
        textContainerInset.top = (frame.height - bounds.height) / 2
    }
    
}
