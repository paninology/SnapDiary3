//
//  NotificationSettingViewController.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/05/24.
//

import UIKit
//시간설정, 날짜설정-매일,매주,매월,매년, 알림끄기

//일단 사용 안함...기획 조정중
final class NotificationSettingViewController: BaseViewController {
    
    let dateOptions = ["매일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일", "매월 1일", "매월 15일"]
    var selectedOption: String?
    
    let currentOptionLabel: UILabel = {
       let view = UILabel()
        view.text = "알림 옵션을 골라주세요"
        return view
    }()
    let datepicker: UIDatePicker = {
       let view = UIDatePicker()
        return view
    }()
    
    let optionPicker: UIPickerView = {
       let view = UIPickerView()
        
        return view
    }()
    
    override func configure() {
        super.configure()
        [datepicker, optionPicker, currentOptionLabel].forEach {view.addSubview($0)}
        optionPicker.delegate = self
        optionPicker.dataSource = self
        view.backgroundColor = .systemBackground
    }
    
    override func setUI() {
        
        currentOptionLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(44)
            make.horizontalEdges.equalToSuperview()
        }
        optionPicker.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(currentOptionLabel.snp.bottom).offset(8)
            make.height.equalTo(100)
        }
        datepicker.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(100)
            make.top.equalTo(optionPicker.snp.bottom).offset(8)
        }
    }
    
    
    
}

extension NotificationSettingViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1 // 피커뷰의 컴포넌트 개수
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return dateOptions.count // 피커뷰의 항목 개수
        }
        
        // MARK: - UIPickerViewDelegate
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return dateOptions[row] // 각 피커뷰 항목의 제목
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            selectedOption = dateOptions[row] // 선택한 옵션 저장
        }
    
    
}
