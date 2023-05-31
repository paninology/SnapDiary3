//
//  CardListView.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/05/26.
//

import UIKit

final class CardListView: BaseView {
    
//    let cancelButton: UIButton = {
//        let view = UIButton(type: .close)
////        view.setTitle("취소", for: .normal)
////        view.setTitleColor(.systemBlue, for: .normal)
//        return view
//    }()
    
    let editButton: UIButton = {
        let view = UIButton()
        view.setTitle("편집", for: .normal)
        view.setTitleColor(.systemBlue, for: .normal)
        return view
    }()
    
    let collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        func createLayout() -> UICollectionViewLayout {
           let config = UICollectionViewCompositionalLayoutConfiguration()
           let layout = createCompositionalLayout()
           layout.configuration = config
           return layout
       }
       
       func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
           return UICollectionViewCompositionalLayout { (sectionIndex, NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
               let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalWidth(0.5))
               let item = NSCollectionLayoutItem(layoutSize: itemSize)
               item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
               let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60))
               let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item] )
               let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .estimated(16), heightDimension: .estimated(44))
               let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind:"section-header-element-kind", alignment: .top)

               sectionHeader.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
               let section = NSCollectionLayoutSection(group: group)
               section.boundarySupplementaryItems = [sectionHeader]
               section.interGroupSpacing = 8
               section.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
               return section
           }
       }
        return view
    }()
    
    override func configure() {
        super.configure()
        backgroundColor = Constants.Color.background
        [dismissButton, collectionView, editButton].forEach {addSubview($0)}
    }
    
    override func setConstraints() {
        super.setConstraints()
        dismissButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8)
            make.top.equalToSuperview().inset(8)
            
        }
        editButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.trailing.equalToSuperview().inset(8)
        }
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(dismissButton.snp.bottom)
            make.bottom.equalToSuperview()
        }
        
    }
   
    
}

final class TitleSupplementaryView: UICollectionReusableView {
    let label = UILabel()
    //...
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
