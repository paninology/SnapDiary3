//
//  CollectionViewBaseCell.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/06/20.
//

import UIKit

class CollectionViewBaseCell: UICollectionViewCell {
    let titleLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    
    let detailLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    let disclosureImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    let button: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("수정", for: .normal)
        //        view.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        view.setTitleColor(.label, for: .normal)
        return view
    }()
    
    let centerView: UIView = {
        let view = UIView()
        view.makeRoundLayer(bgColor: .systemGroupedBackground)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(centerView)
        contentView.addSubview(button)
        contentView.addSubview(titleLabel)
        //            contentView.addSubview(detailLabel)
        //            contentView.addSubview(disclosureImageView)
        centerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(8)
            make.verticalEdges.equalToSuperview().inset(4)
        }
        button.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(8)
            make.trailing.equalToSuperview().inset(12)
            make.width.equalTo(44)
        }
        titleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(12)
            make.trailing.equalTo(button.snp.leading).inset(4)
            
        }
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
