//
//  CollectionViewBaseCell.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/06/20.
//

import UIKit

class CollectionViewBaseCell: UICollectionViewCell {
    let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let detailLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let disclosureImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    let button: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("수정", for: .normal)
        //        view.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        view.setTitleColor(.label, for: .normal)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(button)
        //            contentView.addSubview(detailLabel)
        //            contentView.addSubview(disclosureImageView)
        titleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalToSuperview().inset(4)
            make.trailing.equalTo(button.snp.leading)
            
        }
        button.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(4)
            make.trailing.equalToSuperview().inset(4)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
