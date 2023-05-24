//
//  File.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/05/24.
//

import UIKit
//새일기장: 제목, 알림옵션, 질문덱선택(설정), 사진
final class AddBookViewController: BaseViewController {
    
    let mainView = AddBookView()
    let inputFields = ["제목", "알림옵션", "Choose a deck"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configure() {
        super.configure()
        view = mainView
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        
    }
    
}

extension AddBookViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        inputFields.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = TextFeildTableViewCell()
            cell.textField.delegate = self
            return cell
        } else if indexPath.section == 1 {
            let cell = UITableViewCell()
            var content = cell.defaultContentConfiguration()
            content.text = "알림옵션 변경하기"
            content.secondaryText = "현재 알림옵션: "
            cell.accessoryType = .disclosureIndicator
            cell.contentConfiguration = content
            return cell
        } else {
            let cell = UITableViewCell()
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        inputFields[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        if indexPath.section == 1 {
            
        }
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
