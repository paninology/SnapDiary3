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


    init(card: Card?) {
        super.init(nibName: nil , bundle: nil)
        self.card = card
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repository.showRealmDB()
 
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

    
    @objc private func saveButtonPressed() {
        guard mainView.textView.text != nil else {
            mainView.makeToast("내용을 입력해주세요")
            
            return}
      
        if card != nil { //수정
//            repository.updateItem(item: Card, update: "question", value: mainView.textView.text)
            repository.localRealm.create(Card.self, value: ["question": mainView.textView.text], update: .modified)
        } else { //신규
            let newCard = Card(question: mainView.textView.text)
            repository.addItem(items: newCard)
        }
        dismiss(animated: true)
        if let mainViewController = presentingViewController as? DeckDetailViewController {
            mainViewController.viewWillAppear(true)
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
