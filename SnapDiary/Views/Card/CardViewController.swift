//
//  CardViewController.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/05/31.
//

import UIKit
import RealmSwift
import Toast

final class CardViewController: BaseViewController {
    
    private let mainView = CardView()
    private var card: Card?
    private var isKeyboardVisible = false
    private var isTextEmpty = true {
        didSet {
            mainView.placeHolder.isHidden = !isTextEmpty
            setSaveButton()
        }
    }
//    private var usingDecks:[Deck] {
//        repository.cardUsingDeck(card: card)
//    }


    init(card: Card?) {
        super.init(nibName: nil , bundle: nil)
        self.card = card
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configure() {
        super.configure()
        view = mainView
        isTextEmpty = mainView.textView.text.isEmpty
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        mainView.textView.delegate = self
        mainView.textView.text = card?.question ?? ""
        mainView.placeHolder.isHidden = !mainView.textView.text.isEmpty
        mainView.dismissButton.addTarget(self, action: #selector(dismissButtonPressed), for: .touchUpInside)
        mainView.saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        setSaveButton()
        mainView.deckListLabel.text = getUsingDecks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async { [weak self] in
                self?.setTextViewContentInset()
            }
    }

    private func setTextViewContentInset() {
        let contentSize = mainView.textView.contentSize
        let topMargin = (mainView.textView.bounds.height / 2) - (contentSize.height / 2) - mainView.saveButton.bounds.height/2
        mainView.textView.contentInset = UIEdgeInsets(top: topMargin, left: 0, bottom: 0, right: 0)

    }
    
    private func setSaveButton() {
        if isTextEmpty {
            mainView.saveButton.isEnabled = false
            mainView.saveButton.setTitleColor(.gray, for: .normal)
        } else {
            mainView.saveButton.isEnabled = true
            mainView.saveButton.setTitleColor(.systemBlue, for: .normal)
        }
    }
    
    private func getUsingDecks()-> String {
        guard let card = card else {
            return "현재 사용중이지 않는 카드입니다."
        }
        let text = repository.cardUsingDeck(card: card).joined(separator: ", ")
        return "현재 \(text) 에서 이 카드를 사용중입니다."
        
    }

    
    @objc private func saveButtonPressed() {
        guard mainView.textView.text != nil else {
            mainView.makeToast("내용을 입력해주세요")
            return}
        showAlertWithCompletion(title: "수정하시겠습니까?", message: "수정된 내용은 이 카드를 사용중인 모든 덱에 적용됩니다. \(getUsingDecks())", hasCancelButton: true) { [weak self]_ in
            guard let self = self else {return}
            if card != nil { //수정
                repository.modifyItem { _ in
                    self.card!.question = self.mainView.textView.text
                }
            } else { //신규
                let newCard = Card(question: mainView.textView.text)
                repository.addItem(items: newCard)
            }
            if let mainViewController = presentingViewController as? CardPickerViewContoller {
                mainViewController.viewWillAppear(true)
            }
            dismiss(animated: true)
        }
      
        
    }
    @objc private func keyboardWillShow(notification: NSNotification) {
        isKeyboardVisible = true
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let bottomInset = (keyboardSize.height / 2) 
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: bottomInset, right: 0)
            mainView.textView.contentInset = contentInsets
            mainView.textView.scrollIndicatorInsets = contentInsets
            
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        isKeyboardVisible = false
        setTextViewContentInset()
       
    }
}

extension CardViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        isTextEmpty = textView.text.isEmpty
        if !isKeyboardVisible {
            setTextViewContentInset()
        }
        
    }
   
}
