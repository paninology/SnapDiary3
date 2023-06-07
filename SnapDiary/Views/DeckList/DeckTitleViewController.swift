//
//  DeckTitleViewController.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/06/07.
//

import UIKit

final class DeckTitleViewContoller: BaseViewController {
    
    let titleTextField: UITextField = {
        let view = UITextField()
        view.backgroundColor = Constants.Color.background
        return view
    }()
    
    let saveButton: UIButton = {
        let view = UIButton()
        view.setTitle("저장", for: .normal)
        view.setTitleColor(.systemBlue, for: .normal)
        return view
    }()
    
    let dismissButton: UIButton = {
        let view = UIButton(type: .close)
        return view
    }()
    
    override func configure() {
        super.configure()
        view.backgroundColor = .clear
        view.addSubview(titleTextField)
        view.addSubview(saveButton)
        view.addSubview(dismissButton)
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.trailing.equalTo(16)
            make.width.equalTo(60)
        }
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.leading.equalTo(16)
            make.trailing.equalTo(saveButton.snp.leading).offset(8)
        }
        dismissButton.snp.makeConstraints { make in
            make.top.equalTo(96)
            make.leading.equalTo(14)
            
        }
        
    }
    
    
    
    
}
