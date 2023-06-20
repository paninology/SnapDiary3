//
//  CardPickerViewController.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/06/08.
//

import UIKit
import RealmSwift

final class CardPickerViewContoller: BaseViewController {
    
    var dataSource: UICollectionViewDiffableDataSource<Int, Card>!
    private let mainView = CardPickerView()
    private let deck: Deck
    private var cards: [Card] = [] {
        didSet {
            makeSnapShot(items: cards, dataSource: dataSource)
        }
    }
//    private var deckCards: [Card] = []
    private var selectedCards:[Card] = []
    private var plusCard = Card(question: "새카드 만들기")
    
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
//        makeSnapShot(items: cards, dataSource: dataSource)
        fetchCards()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCards()
        updateSection()
        print("cardPciker view will")
    }
    
    override func configure() {
        super.configure()
        mainView.listView.collectionView.delegate = self
        mainView.addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
        mainView.dismissButton.addTarget(self, action: #selector(dismissButtonPressed), for: .touchUpInside)
    }
    
    private func fetchCards() {
        let result = self.repository.fetch(model: Card.self)
        self.cards = Array(result)
     
    }
   
    private func addNewCard() {
        var snapShot = dataSource.snapshot()
//        snapShot.appendSections([0])
        snapShot.appendItems([plusCard], toSection: 0)
        dataSource.apply(snapShot)
    }
    override func makeSnapShot<T>(items: [T], dataSource: UICollectionViewDiffableDataSource<Int, T>) where T : Hashable {
        super.makeSnapShot(items: items, dataSource: dataSource)
        addNewCard()
    }
    private func updateSection() {
        var snapshot = dataSource.snapshot()
        snapshot.reloadSections([0])
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    @objc private func addButtonClicked() {
      
        repository.appendCardToDeck(cards: selectedCards, deck: deck)
        refreshRootViewWillAppear(type: DeckDetailViewController.self)
        dismiss(animated: true)
    }
    @objc private func cellButtonPressed(sender: UIButton) {
      
        transition(CardViewController(card: cards[sender.tag]), transitionStyle: .presentOverFull)
    }
}

//MARK: CollectionView datasource
extension CardPickerViewContoller {
    private func configureDataSource() {
        /*
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Card>.init { cell, indexPath, itemIdentifier in
            var content = cell.defaultContentConfiguration()
            content.text = itemIdentifier.question
            content.prefersSideBySideTextAndSecondaryText = false
            content.textProperties.alignment = .center
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            if indexPath.item == self.cards.count { //새카드만들기 셀
                backgroundConfig.backgroundColor = .systemGray5
            } else { //기존 카드셀
                if self.deck.cards.contains(itemIdentifier) { //이미 사용중인 카드
                    cell.alpha = 0.5
//                    cell.isUserInteractionEnabled = false
                    cell.selections
                    print(itemIdentifier, cell.alpha)
                }
                let cellView = SingleButtonView()
                cellView.button.addTarget(self, action: #selector(self.cellButtonPressed), for: .touchUpInside)
                cell.accessories = [.customView(configuration: .init(customView: cellView, placement: .trailing()))]
                cellView.button.tag = indexPath.item
            }
            backgroundConfig.backgroundColor = .systemGroupedBackground
            backgroundConfig.cornerRadius = 10
            backgroundConfig.strokeWidth = 1
            backgroundConfig.backgroundInsets = .init(top: 4, leading: 8, bottom: 4, trailing: 8)
            cell.contentConfiguration = content
            cell.backgroundConfiguration = backgroundConfig            
            
        }
         */
        let cellRegistration = UICollectionView.CellRegistration
        //numberOfItemsInSection, cellForItemAt
        dataSource = UICollectionViewDiffableDataSource(collectionView: mainView.listView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    

}

extension CardPickerViewContoller: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        guard indexPath.item < cards.count else {
            transition(CardViewController(card: nil), transitionStyle: .presentOverFull)
            return }
        let selected = cards[indexPath.item]
        var config = cell.backgroundConfiguration
        if selectedCards.contains(selected) {
                if let index = selectedCards.firstIndex(of: selected) {
                    selectedCards.remove(at: index)
                    config?.backgroundColor = .systemGroupedBackground
                    cell.backgroundConfiguration = config
                }
            } else {
                selectedCards.append(selected)
                config?.backgroundColor = .systemGray3
                cell.backgroundConfiguration = config
            }
    }
}
