//
//  CardListViewController.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/05/26.
//

import UIKit
//import RealmSwift

//delete logic 수정필요.
final class CardListViewController: BaseViewController {

    var dataSource: UICollectionViewDiffableDataSource<Int, Card>!
    private let mainView = CardListView()
    
    private var isEditingNow = false {
        didSet {
            let title = isEditingNow ? "확인" : "편집"

            makeSnapShot()
            mainView.editButton.setTitle(title, for: .normal)
        }
    }
    private var deckCards: [Card] = [] {
        didSet {
            print(deckCards)
            makeSnapShot()
        }
    }

    private let plusCard = Card(question: "새카드 추가")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        
        configureDataSource()
        makeSnapShot()
        print(deckCards)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCards()
    }

    override func configure() {
        super.configure()
        mainView.dismissButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        mainView.editButton.addTarget(self, action: #selector(editButtonPressed), for: .touchUpInside)
        mainView.collectionView.delegate = self
    }
    
    private func newCardCellConfig(cell: CardCollectionViewCell) {
        cell.deleteButton.isHidden = true
        cell.questionLabel.layer.borderWidth = 2
        cell.questionLabel.layer.borderColor = UIColor.systemGray.cgColor
        cell.questionLabel.font = .boldSystemFont(ofSize: 16)
//                cell.questionLabel.text = "새카드 추가하기"
    }
    
    private func fetchCards() {
        DispatchQueue.main.async {
            
            let result = self.repository.fetch(model: Card.self)
            self.deckCards = Array(result)
        }
    }
    
    @objc private func cancelButtonPressed(sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc private func editButtonPressed(sender: UIButton) {
        isEditingNow.toggle()
//        print(isEditingNow)////
    }
    
    @objc private func deleteButtonPressed(sender: UIButton) {
        print(sender.tag)
        print("deledted:", deckCards[sender.tag])
        var snapshot = dataSource.snapshot()
        snapshot.deleteItems([deckCards[sender.tag]])
        dataSource.apply(snapshot)
        repository.deleteItem(item: self.deckCards[sender.tag])
        let result = self.repository.fetch(model: Card.self)
        print("result:",result)
  
        print(sender.tag)
    }
    private func makeSnapShot() {
        
            var snapshot = NSDiffableDataSourceSnapshot<Int, Card>()
            snapshot.appendSections([0])
            snapshot.appendItems(self.deckCards, toSection: 0)
            snapshot.reloadItems(self.deckCards)
            snapshot.appendItems([self.plusCard])
            self.dataSource.apply(snapshot)
           
        
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
             cell.questionLabel.text = "  \(itemIdentifier.question)  "
            cell.deleteButton.tag = indexPath.item
            cell.deleteButton.isHidden = !self.isEditingNow
            cell.deleteButton.addTarget(self, action: #selector(deleteButtonPressed), for: .touchUpInside)
            if indexPath.item == deckCards.count { //새카드셀
               newCardCellConfig(cell: cell)
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

}


extension CardListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == deckCards.count { //새카드 아이템 누르면
            transition(CardViewController(card: nil), transitionStyle: .presentOverFull)
        } else {
            transition(CardViewController(card: deckCards[indexPath.item]), transitionStyle: .presentOverFull)
            
        }

    }
}
