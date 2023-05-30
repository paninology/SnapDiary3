//
//  CardCollectionViewCell.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/05/26.
//

import UIKit

final class CardCollectionViewCell: UICollectionViewCell {
    
    let questionLabel: UILabel = {
       let view = UILabel()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.font = .systemFont(ofSize: 14)
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()
    
    let deleteButton: UIButton = {
       let view = UIButton()
        view.setImage(.remove, for: .normal)

        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(questionLabel)
        addSubview(deleteButton)
        questionLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(4)

        }
        deleteButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
