//
//  NotificationOptionCell.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/05/25.
//

import UIKit

final class NotificationOptionCell: UITableViewCell {
    
    let datepicker: UIDatePicker = {
       let view = UIDatePicker()
        view.datePickerMode = .time
        return view
    }()
    
    let optionPicker: UIPickerView = {
       let view = UIPickerView()
        
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.subviews.forEach { $0.removeFromSuperview() }
        [datepicker, optionPicker].forEach {addSubview($0)}
        optionPicker.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalTo(240)
            
        }
        datepicker.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.trailing.equalToSuperview().inset(12)
        }
       
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
