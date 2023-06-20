//
//  SingleButtonView.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/06/19.
//

import UIKit

final class SingleButtonView: UIView {
    
    let button: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("수정", for: .normal)
//        view.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        view.setTitleColor(.label, for: .normal)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(button)
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
