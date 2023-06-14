//
//  File.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/05/24.
//

import UIKit
import RealmSwift
//새일기장: 제목, 알림옵션, 질문덱선택(설정), 사진
//추천 일기옵션 제공
//mvvm으로 변경??
final class AddBookViewController: BaseViewController {
    
    private let mainView = AddBookView()
    private let inputFields = ["제목", "설명", "알림옵션", "질문카드 고르기"]
    private let dateOptions = ["매일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일", "매월 1일", "매월 15일"]
    private var decks: [Deck] = []
    private var fetchedDecks: Results<Deck>? {
        didSet {
            if let result = fetchedDecks {
                decks = Array(result)
                print("fetched", decks)
            } else {
                decks = []
            }
        }
    }
    private var selectedOption: String?
    private var selectedDeck: Deck?
    private var isNotiOn = true
    private var titleText = ""
    private var subTitleText = ""
    private var notificationDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchedDecks = repository.fetch(model: Deck.self)
        mainView.tableView.reloadRows(at: [IndexPath(row: 0, section: 3)], with: .automatic)
        if decks != [] {
            selectedDeck = decks[0]
        }
    }
    
    override func configure() {
        super.configure()
        view = mainView
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonPressed))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        mainView.tableView.addGestureRecognizer(tapGesture)
        
        print("selected deck:", selectedDeck)
        
    }
    private func newDeckName()-> String {
        var newTitle = "내카드덱(1)"
        var count = 2

        while decks.contains(where: { $0.title == newTitle }) {
            newTitle = "내카드덱(\(count))"
            count += 1
        }
        return newTitle
    }
    
    @objc func hideKeyboard() {
            view.endEditing(true) // 다른 곳 탭 시 키보드 내리기
        }
    
    @objc private func saveButtonPressed(sender: UIButton) {      
        let book = Book(title: titleText, deckID: ObjectId(), subtitle: subTitleText)
    }
    @objc private func selectSwitchChanged(sender: UISwitch) {
        isNotiOn = sender.isOn
        mainView.tableView.reloadData()
    }
    
    @objc private func cardDetailButtonPressed(sender: UIButton) {
        guard decks != [] else {
            let select = decks[0]
            transition(DeckDetailViewController(deck: select), transitionStyle: .presentOverFull)
            return
        }
      
        if let select = selectedDeck {
            transition(DeckDetailViewController(deck: select), transitionStyle: .presentOverFull)
        } else {
            let newDeck = Deck(title: newDeckName(), questions: List<Card>())
            repository.addItem(items: newDeck)
            transition(DeckDetailViewController(deck: newDeck), transitionStyle: .presentOverFull)
        }
    }
    @objc private func dateChanged(sender: UIDatePicker) {
        notificationDate = sender.date
    }
}

extension AddBookViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        inputFields.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
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
            let cell = TextFeildTableViewCell()
            cell.textField.placeholder = "일기장에 대한 설명을 써주세요"
            cell.textField.delegate = self
            return cell
        
        } else if indexPath.section == 2 {
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
                cell.optionPicker.tag = 0
                cell.datepicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
                return cell
            }
        } else {
            let cell = DeckPickerCell()
            cell.deckPicker.delegate = self
            cell.deckPicker.dataSource = self
            cell.deckPicker.tag = 1
            cell.detailButton.addTarget(self, action: #selector(cardDetailButtonPressed), for: .touchUpInside)
            if let deckForCell = selectedDeck {
                let picked = decks.firstIndex(of: deckForCell) ?? 0
                cell.deckPicker.selectRow(picked, inComponent: 0, animated: true)
            }
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        inputFields[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 2 {
            if indexPath.row == 0 {
                return 44
            } else {
                return isNotiOn ? 80 : 0
            }
        } else if indexPath.section == 3 {
            return 88
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
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.tag == 0 {
            titleText = textField.text ?? ""
        } else {
            
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // 키보드 내리기
        return true
    }

}
    
    // MARK: - UIPickerViewDelegate
extension AddBookViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // 피커뷰의 컴포넌트 개수
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return dateOptions.count // 피커뷰의 항목 개수
        } else {
            return decks.count + 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            return dateOptions[row] // 각 피커뷰 항목의 제목
        } else {
            if row < decks.count {
                return decks[row].title
            } else {
                return "새로운 덱"
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 { //알림옵션
            selectedOption = dateOptions[row]
        } else { //덱 피커
            if row < decks.count {
                selectedDeck = decks[row]
                print("selected:", selectedDeck)
            }else {
                selectedDeck = nil
            }
        }
    }
   

}


