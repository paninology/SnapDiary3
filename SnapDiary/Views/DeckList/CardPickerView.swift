//
//  CardPickerView.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/06/08.
//

import UIKit

final class CardPickerView: BaseView {
    
    let centerView: UIView = {
       let view = UIView()
        view.backgroundColor = Constants.Color.background
        return view
    }()
    let listView = ListView()
    
    let addButton: UIButton = {
        let view = UIButton()
        view.setTitle("추가", for: .normal)
        view.setTitleColor(Constants.Color.buttonText, for: .normal)
        return view
        
    }()
    
    
    override func configure() {
        super.configure()
        backgroundColor = .clear
        [centerView, listView, dismissButton, addButton].forEach{addSubview($0)}
        centerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(44)
            make.verticalEdges.equalToSuperview().inset(60)
//            make.height.equalTo(centerView.snp.width).multipliedBy(1.7)
        }
        dismissButton.snp.makeConstraints { make in
            make.top.equalTo(centerView.snp.top).inset(4)
            make.leading.equalTo(centerView.snp.leading).inset(4)
        }
        addButton.snp.makeConstraints { make in
            make.top.equalTo(centerView.snp.top).inset(4)
            make.trailing.equalTo(centerView.snp.trailing).inset(4)
            
        }
        listView.snp.makeConstraints { make in
            make.top.equalTo(addButton.snp.bottom).offset(4)
            make.bottom.equalTo(centerView.snp.bottom)
            make.horizontalEdges.equalTo(centerView.snp.horizontalEdges)
        }
    }
}
