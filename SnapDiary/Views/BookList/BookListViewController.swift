//
//  MainViewController.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/05/19.
//

import UIKit
import RealmSwift

final class BookListViewController: BaseViewController {
    
    
    var dataSource: UICollectionViewDiffableDataSource<Int, Book>!
    let mainView = ListView()
    
    var bookList: [Book] = [
        Book(title: "내일기", deckID: ObjectId(), subtitle: "나의 생활에 관한 일기이다."),
        Book(title: "연애일기", deckID: ObjectId(), subtitle: "여친과 데이트 한 일들을 기록하는 일기이다. ㅇㄴㅁㅇㄴㄹㅁㄴㅇㄹㅁㄴㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㅇㄴㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹ")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        configureDataSource()
        makeSnapShot(books: bookList)
        print(repository.localRealm.configuration.fileURL)
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

        //numberOfItemsInSection, cellForItemAt
        dataSource = UICollectionViewDiffableDataSource(collectionView: mainView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)

            return cell
            
        })
        
    }
    
    private func makeSnapShot(books: [Book]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Book>()
        snapshot.appendSections([0])
        snapshot.appendItems(books, toSection: 0)
        dataSource.apply(snapshot)
    }
}
