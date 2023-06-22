//
//  DiaryCollectionViewCell.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/06/21.
//

import UIKit

final class DiaryCollectionViewCell: UICollectionViewCell {
    
    var isFlipped = false

    let frontView: UIView = {
       let view = UIView()
        view.layer.borderColor = UIColor.black.cgColor
        view.makeRoundLayer(bgColor: .orange)
        return view
    }()
    let backView: UIView = {
       let view = UIView()
        view.layer.borderColor = UIColor.black.cgColor
        view.makeRoundLayer(bgColor: .brown)
        return view
    }()
    let dateLabel: UILabel = {
       let view = UILabel()
        view.font = .systemFont(ofSize: 10)
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    
    let questionLabel: UILabel = {
       let view = UILabel()
        view.font = .systemFont(ofSize: 14)
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()
    
    let diaryLabel: UILabel = {
       let view = UILabel()
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
 
        [ backView,frontView, deleteButton].forEach {addSubview($0)}
        [dateLabel, questionLabel].forEach { frontView.addSubview($0)}
        backView.addSubview(diaryLabel)
        frontView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        dateLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(8)
            make.top.equalToSuperview().inset(8)
            make.height.equalTo(24)
        }
        questionLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(4)
            make.top.equalTo(dateLabel.snp.bottom)
            make.bottom.equalToSuperview().inset(4)
        }
        diaryLabel.snp.makeConstraints { make in
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
