//
//  File.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/05/24.
//

import UIKit
//새일기장: 제목, 알림옵션, 질문덱선택(설정), 사진
//추천 일기옵션 제공
final class AddBookViewController: BaseViewController {
    
    let mainView = AddBookView()
    let inputFields = ["일기장 제목", "알림옵션", "질문덱"]
    let dateOptions = ["매일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일", "매월 1일", "매월 15일"]
    var selectedOption: String?
    var isNotiOn = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configure() {
        super.configure()
        view = mainView
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        
    }
    @objc private func selectSwitchChanged(sender: UISwitch) {
        isNotiOn = sender.isOn
        mainView.tableView.reloadData()
    }

    
}

extension AddBookViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        inputFields.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = TextFeildTableViewCell()
            cell.textField.delegate = self
            return cell
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                let cell = SwitchTableViewCell()
                cell.selectSwitch.addTarget(self, action: #selector(selectSwitchChanged), for: .valueChanged)
                cell.selectSwitch.isOn = isNotiOn
                cell.titleLabel.text = "알림"
                return cell
            } else {
                let cell = NotificationOptionCell()
                cell.optionPicker.delegate = self
                cell.optionPicker.dataSource = self
                return cell
            }
         
        } else {
            let cell = UITableViewCell()
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        inputFields[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                return 44
            } else {
                return isNotiOn ? 88 : 0
            }
        } else {
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
//        if indexPath.section == 1 {
//            transition(NotificationSettingViewController(), transitionStyle: .push)
//        }
    }
    
    
}
extension AddBookViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 현재 텍스트 필드에 입력된 글자 수와 추가될 글자 수를 계산
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        let maxLength = 20 // 최대 글자 수 제한
        
        // 글자 수가 최대 길이를 초과하면 입력을 막음
        return newText.count <= maxLength
    }

}

extension AddBookViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
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