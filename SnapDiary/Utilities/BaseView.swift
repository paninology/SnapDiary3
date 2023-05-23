//
//  BaseView.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/05/22.
//

import UIKit
import SnapKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
       
    }
    
    func setConstraints() {
        
    }
}
