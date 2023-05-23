//
//  MainViewController.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/05/19.
//

import UIKit

final class BookListViewController: BaseViewController {
    
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, Book>!
    var dataSource: UICollectionViewDiffableDataSource<Int, Book>!
    let mainView = BookListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        configureDataSource()
        
    }
    
    
    
}

extension BookListViewController {
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Book>.init { cell, indexPath, itemIdentifier in
            
            var content = cell.defaultContentConfiguration()
            content.text = "test"
            content.textProperties.color = .red
            content.secondaryText = "안녕하세요"
            content.prefersSideBySideTextAndSecondaryText = false
            content.textToSecondaryTextVerticalPadding = 20
            cell.contentConfiguration = content
            
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            backgroundConfig.backgroundColor = .lightGray
            backgroundConfig.cornerRadius = 10
            backgroundConfig.strokeWidth = 2
            backgroundConfig.strokeColor = .systemPink
            cell.backgroundConfiguration = backgroundConfig
        }
        
        //collectionView.dataSource = self
        //numberOfItemsInSection, cellForItemAt
        dataSource = UICollectionViewDiffableDataSource(collectionView: mainView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)

            return cell
            
        })
        
    }
    
    private func makeSnapShot(book: Book) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Book>()

        snapshot.appendSections([0])
        snapshot.appendItems([book], toSection: 0)

        dataSource.apply(snapshot)
    }
}
