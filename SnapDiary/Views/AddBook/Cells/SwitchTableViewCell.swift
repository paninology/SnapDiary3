//
//  SwitchTableViewCell.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/05/25.
//

import UIKit

final class SwitchTableViewCell: UITableViewCell {
    
    let titleLabel: UILabel = {
       let view = UILabel()
        return view
    }()
    
    let selectSwitch: UISwitch = {
       let view = UISwitch()
//        view.isOn = true
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.subviews.forEach { $0.removeFromSuperview() }
        addSubview(titleLabel)
        addSubview(selectSwitch)
        titleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalToSuperview().inset(12)
        }
        selectSwitch.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(12)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
