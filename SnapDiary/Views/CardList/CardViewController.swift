//
//  CardViewController.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/05/31.
//

import UIKit

final class CardViewController: BaseViewController {
    
    let mainView = CardView()
    var card: Card?


    init(card: Card?) {
        super.init(nibName: nil , bundle: nil)
        self.card = card
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        mainView.textView.delegate = self
        mainView.textView.text = card?.question ?? ""
        mainView.placeHolder.isHidden = !mainView.textView.text.isEmpty
        mainView.dismissButton.addTarget(self, action: #selector(dismissButtonPressed), for: .touchUpInside)
    }
    
    @objc private func dismissButtonPressed() {
        dismiss(animated: true)
    }
}

extension CardViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        mainView.placeHolder.isHidden = !textView.text.isEmpty
        let contentSize = textView.contentSize
        let topMargin = (textView.bounds.height / 2) - contentSize.height
        mainView.textView.contentInset = UIEdgeInsets(top: topMargin, left: 20, bottom: 20, right: 20)
//        mainView.textView.snp.updateConstraints { make in
//            make.height.equalTo(contentSize.height)
//        }
    }
   
}
