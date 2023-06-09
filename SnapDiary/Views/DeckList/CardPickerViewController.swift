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
            makeSnapShot()
        }
    }
    private var selectedCards:[Card] = []
    
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
        fetchCards()
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
    @objc private func addButtonClicked() {
        repository.appendCardToDeck(cards: selectedCards, deck: deck)
        refreshRootViewWillAppear(type: DeckDetailViewController.self)
        dismiss(animated: true)
    }
    
}

//MARK: CollectionView datasource
extension CardPickerViewContoller {
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Card>.init { cell, indexPath, itemIdentifier in
            var content = cell.defaultContentConfiguration()
            content.text = itemIdentifier.question
            content.prefersSideBySideTextAndSecondaryText = false
            content.textToSecondaryTextVerticalPadding = 20
            cell.contentConfiguration = content
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            backgroundConfig.backgroundColor = .systemGroupedBackground
            backgroundConfig.cornerRadius = 10
            backgroundConfig.strokeWidth = 1
            backgroundConfig.backgroundInsets = .init(top: 4, leading: 8, bottom: 4, trailing: 8)
            cell.backgroundConfiguration = backgroundConfig
        }

        //numberOfItemsInSection, cellForItemAt
        dataSource = UICollectionViewDiffableDataSource(collectionView: mainView.listView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)

            return cell
            
        })
        
    }
    
    private func makeSnapShot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Card>()
        snapshot.appendSections([0])
        snapshot.appendItems(cards, toSection: 0)
        dataSource.apply(snapshot)
    }
}

extension CardPickerViewContoller: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) else {
              return
          }
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
