//
//  CardListViewController.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/05/26.
//

import UIKit

final class CardListViewController: BaseViewController {

    var dataSource: UICollectionViewDiffableDataSource<Int, Card>!
    let mainView = CardListView()
    
    var isEditingNow = false {
        didSet {
            let title = isEditingNow ? "확인" : "편집"
            var cards: [Card]
            if isEditingNow {
                cards = baseCards
                cards.append(plusCard)
                makeSnapShot(cards: cards)
            } else {
                makeSnapShot(cards: baseCards)
            }
//            makeSnapShot(cards: baseCards)
            mainView.editButton.setTitle(title, for: .normal)
        }
    }
 
    let baseCards = [
        Card(question: "테스트질문1"),
        Card(question: "오늘 점심메뉴는?"),
        Card(question: "이번주에 아기가 새로 배운 말"),
        Card(question: "안녕"),
        Card(question: "alsdkfjas;dlkfjalsdkfjas;ldfkjas;ldfkjasldfkjalksdfjalksdfjalkjdslakdfjs테스트테스트테스트alsdkfjas;dlkfjalsdkfjas;ldfkjas;ldfkjasldfkjalksdfjalksdfjalkjdslakdfjs테스트테스트테스트alsdkfjas;dlkfjalsdkfjas;ldfkjas;ldfkjasldfkjalksdfjalksdfjalkjdslakdfjs테스트테스트테스트")
    ]
    let plusCard = Card(question: "새카드 추가")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        configureDataSource()
        makeSnapShot(cards: baseCards)
    }
    
    override func configure() {
        super.configure()
        mainView.cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        mainView.editButton.addTarget(self, action: #selector(editButtonPressed), for: .touchUpInside)
    }
    
    @objc private func cancelButtonPressed(sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc private func editButtonPressed(sender: UIButton) {
        isEditingNow.toggle()
        print(isEditingNow)////////////
    }
    
    @objc  func deleteButtonPressed(sender: UIButton) {
//        snapshot.deleteItems([baseCards[sender.tag]])
        printContent(baseCards)
    }
    
}

//MARK: CollectionView datasource
extension CardListViewController {
    private func configureDataSource() {
        let headerRegistration = UICollectionView.SupplementaryRegistration
               <TitleSupplementaryView>(elementKind: "section-header-element-kind") {
                   (supplementaryView, string, indexPath) in
                   supplementaryView.label.text = "질문카드"
               }
        
        let cellRegistration = UICollectionView.CellRegistration<CardCollectionViewCell, Card>.init { [weak self] cell, indexPath, itemIdentifier in
            guard let self = self else {return}
            cell.questionLabel.font = .systemFont(ofSize: 14)
             cell.questionLabel.text = "  \(itemIdentifier.question)  "
            cell.questionLabel.layer.borderColor = UIColor.gray.cgColor
            cell.questionLabel.textColor = UIColor.gray
            cell.deleteButton.tag = indexPath.item
            cell.deleteButton.isHidden = !self.isEditingNow
            cell.deleteButton.addTarget(self, action: #selector(deleteButtonPressed), for: .touchUpInside)
            if indexPath.item == baseCards.count {
                cell.deleteButton.isHidden = true
//                cell.questionLabel.font = .systemFont(ofSize: 20)
            }
        }
        
        //collectionView.dataSource = self
        //numberOfItemsInSection, cellForItemAt
        dataSource = UICollectionViewDiffableDataSource(collectionView: mainView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })

        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.mainView.collectionView.dequeueConfiguredReusableSupplementary(
                        using: headerRegistration , for: index)
                }
        
    }
   
    private func makeSnapShot(cards: [Card]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Card>()
        snapshot.appendSections([0])
        snapshot.appendItems(cards, toSection: 0)
//        snapshot.deleteItems(<#T##identifiers: [Card]##[Card]#>)
        snapshot.reloadItems(cards)
        dataSource.apply(snapshot)
    }
    
//    private func
}


extension CardListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == baseCards.count {
//            print("item", indexPath.item)
        }
    }
}
