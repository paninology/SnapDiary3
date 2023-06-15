//
//  MainViewController.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/05/19.
//

import UIKit
import RealmSwift

final class BookListViewController: BaseViewController {
        
    private var dataSource: UICollectionViewDiffableDataSource<Int, Book>!
    private let mainView = ListView()
    private var bookList: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        configureDataSource()
        print(repository.localRealm.configuration.fileURL ?? "localRealm non found")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bookList = Array(repository.fetch(model: Book.self))
        makeSnapShot(items: bookList, dataSource: dataSource)
    }
    
    override func configure() {
        super.configure()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(addBookButtonClicked))
    }
    
    @objc private func addBookButtonClicked() {
        transition(AddBookViewController(), transitionStyle: .push)
    }
}

//MARK: CollectionView datasource
extension BookListViewController {
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Book>.init { cell, indexPath, itemIdentifier in
            var content = cell.defaultContentConfiguration()
            content.text = itemIdentifier.title
            content.secondaryText = itemIdentifier.subtitle
            content.image = UIImage(systemName: "person")
            content.prefersSideBySideTextAndSecondaryText = false
            content.textToSecondaryTextVerticalPadding = 20
            cell.contentConfiguration = content
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            backgroundConfig.backgroundColor = .systemGroupedBackground
            backgroundConfig.cornerRadius = 10
            backgroundConfig.strokeWidth = 1
            //            backgroundConfig.strokeColor = .label
            backgroundConfig.backgroundInsets = .init(top: 4, leading: 8, bottom: 4, trailing: 8)
            cell.backgroundConfiguration = backgroundConfig
        }

        dataSource = UICollectionViewDiffableDataSource(collectionView: mainView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            
            return cell
        })
    }
}
