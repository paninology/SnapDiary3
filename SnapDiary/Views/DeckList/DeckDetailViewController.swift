//
//  CardListViewController.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/05/26.
//

import UIKit
//import RealmSwift
struct Section: Hashable {
       var User: User
   }
//delete logic 수정필요.
final class DeckDetailViewController: BaseViewController {
    
    var dataSource: UICollectionViewDiffableDataSource<Int, Card>!
    private let mainView = CardListView()
    var deck: Deck
    
    
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
//            fetchCards()
            makeSnapShot()
        }
    }
    
    private let plusCard = Card(question: "카드 불러오기")
    
    init(deck: Deck) {
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
        
        deck = refreshDeckFromRealm(deck: deck) ?? deck
        fetchCards()
        makeSnapShot()
        updateDeckTitle()
        print("deckdetail willapear", deck.title)
    }
    
    override func configure() {
        super.configure()
        mainView.dismissButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        mainView.editButton.addTarget(self, action: #selector(editButtonPressed), for: .touchUpInside)
        mainView.editDeckTitleButton.addTarget(self, action: #selector(editDeckTitleButtonPressed), for: .touchUpInside)
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
        deckCards = Array(deck.cards)
    }
    
    private func refreshDeckFromRealm(deck: Deck) -> Deck? {
        guard let realm = deck.realm else {
            return nil // Realm 인스턴스를 가져올 수 없는 경우 nil 반환
        }
        
        let refreshedDeck = realm.object(ofType: Deck.self, forPrimaryKey: deck.objectId)

        print("refres:",refreshedDeck)
        return refreshedDeck
    }
    
    @objc private func cancelButtonPressed(sender: UIButton) {
        print("cancelbutton")
//        refreshRootViewWillAppear(type: AddBookViewController.self)
        if let navigationController = presentingViewController as? UINavigationController,
              let addBookVC = navigationController.topViewController as? AddBookViewController {
               dismiss(animated: true) {
                   addBookVC.viewWillAppear(true)
               }
           }
       
    }
    
    @objc private func editButtonPressed(sender: UIButton) {
        isEditingNow.toggle()
        //        print(isEditingNow)////
    }
    
    @objc private func deleteButtonPressed(sender: UIButton) {

        var snapshot = dataSource.snapshot()
        snapshot.deleteItems([deckCards[sender.tag]])
        dataSource.apply(snapshot)
        try! repository.localRealm.write {
            deck.cards.remove(at: sender.tag)
        }
        if let deckFromDB = repository.localRealm.object(ofType: Deck.self, forPrimaryKey: deck.objectId) {
            deck = deckFromDB
            fetchCards()
        }

    }
    func updateDeckTitle() {
    }
     func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Card>()
        snapshot.appendSections([0])
         snapshot.appendItems(self.deckCards, toSection: 0)
//         snapshot.reloadItems(self.deckCards) //따로 빼고싶은데 에러난다
         snapshot.appendItems([self.plusCard])
        dataSource.apply(snapshot, animatingDifferences: true)
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
extension DeckDetailViewController {
    private func configureDataSource() {
        let headerRegistration = UICollectionView.SupplementaryRegistration
        <TitleSupplementaryView>(elementKind: "section-header-element-kind") { [weak self]
                   (supplementaryView, string, indexPath) in
            guard let self = self else {return}
//            supplementaryView.label.text = deck.title
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
            let header = view.dequeueConfiguredReusableSupplementary(
                using: headerRegistration , for: index)
            header.label.text = self.deck.title
            print("suppl label", header.label.text)
            return header
                }
        
    }

}


extension DeckDetailViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == deckCards.count { //새카드 아이템 누르면
            transition(CardPickerViewContoller(deck: deck), transitionStyle: .presentOverFull)
        } else {
            transition(CardViewController(card: deckCards[indexPath.item]), transitionStyle: .presentOverFull)
            
        }

    }
   
}
