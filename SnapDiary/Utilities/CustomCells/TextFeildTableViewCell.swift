//
//  TextFeildTableViewCell.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/05/24.
//

import UIKit
import SnapKit

final class TextFeildTableViewCell: UITableViewCell {
    
    let textField: UITextField = {
       let view = UITextField()
        view.placeholder = "일기장의 제목을 정해주세요"
        
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.subviews.forEach { $0.removeFromSuperview() }
        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(8)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
