//
//  CardListViewController.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/06/08.
//

import UIKit
//import RealmSwift


//delete logic 수정필요.

/*
final class CardListViewController: BaseViewController {
    
    var dataSource: UICollectionViewDiffableDataSource<Int, Card>!
    private let mainView = CardListView()
    var deck: Deck?
    
    private var isEditingNow = false {
        didSet {
            let title = isEditingNow ? "확인" : "편집"
            makeSnapShot()
            mainView.editButton.setTitle(title, for: .normal)
            mainView.editDeckTitleButton.isHidden = !isEditingNow
        }
    }
    private var deckCards: [Card] = [] {
        didSet {
            print(deckCards)
            makeSnapShot()
        }
    }
    
    private let plusCard = Card(question: "새카드 추가")
    
    init(deck: Deck?) {
        self.deck = deck
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
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
        mainView.dismissButton.addTarget(self, action: #selector(dismissButtonPressed), for: .touchUpInside)
        mainView.editButton.addTarget(self, action: #selector(editButtonPressed), for: .touchUpInside)
        mainView.collectionView.delegate = self
        mainView.editDeckTitleButton.isHidden = !isEditingNow
    }
    
    private func newCardCellConfig(cell: CardCollectionViewCell) {
        cell.deleteButton.isHidden = true
        cell.questionLabel.layer.borderWidth = 2
        cell.questionLabel.layer.borderColor = UIColor.systemGray.cgColor
        cell.questionLabel.font = .boldSystemFont(ofSize: 16)
        //                cell.questionLabel.text = "새카드 추가하기"
    }
    
    private func fetchCards() {
        let result = self.repository.fetch(model: Card.self)
        self.deckCards = Array(result)
        
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
        snapshot.reloadItems(self.deckCards) //따로 빼고싶은데 에러난다
        snapshot.appendItems([self.plusCard])
        self.dataSource.apply(snapshot)
    }
    @objc func editDeckTitleButtonPressed(sender: UIButton) {
        print("edittitle")
        transition(DeckTitleViewContoller(deck: deck), transitionStyle: .presentOverFull)
    }
   
}

//MARK: CollectionView datasource
extension CardListViewController {
    private func configureDataSource() {
        let headerRegistration = UICollectionView.SupplementaryRegistration
        <TitleSupplementaryView>(elementKind: "section-header-element-kind") { [weak self]
                   (supplementaryView, string, indexPath) in
            guard let self = self else {return}
            supplementaryView.label.text = deck?.title ?? "새로운 덱"
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

*/
