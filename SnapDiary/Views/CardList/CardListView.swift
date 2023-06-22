//
//  CardListView.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/05/26.
//

import UIKit

final class CardListView: BaseView {
    

    let editButton: UIButton = {
        let view = UIButton()
        view.setTitle("편집", for: .normal)
        view.setTitleColor(.systemBlue, for: .normal)
        return view
    }()
    
    let editDeckTitleButton: UIButton = {
       let view = UIButton()
        view.setTitle("제목수정", for: .normal)
        view.setTitleColor(.systemBlue, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
//        view.isUserInteractionEnabled = true
        view.isEnabled = true
        return view
    }()

    let collectionView = CardListCollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    override func configure() {
        super.configure()
        [dismissButton, collectionView, editButton, editDeckTitleButton].forEach {addSubview($0)}
    }
    
    override func setConstraints() {
        super.setConstraints()
        dismissButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8)
            make.top.equalToSuperview().inset(8)
            
        }
        editButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.trailing.equalToSuperview().inset(8)
        }
        editDeckTitleButton.snp.makeConstraints { make in
//            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalTo(collectionView.snp.top)
        }
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(dismissButton.snp.bottom).offset(8)
            make.bottom.equalToSuperview()
        }
    }
}

final class TitleSupplementaryView: UICollectionReusableView {
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.subviews.forEach { $0.removeFromSuperview() }
        addSubview(label)

        label.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.centerX.equalToSuperview()
//            make.horizontalEdges.equalToSuperview().offset(16)
            make.width.lessThanOrEqualTo(280)
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func testt() {
        print("tttttt")
    }
    
    
}
