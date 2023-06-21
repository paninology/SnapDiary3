//
//  BookView.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/06/21.
//

import UIKit
//1.일기장 제목, 2.설명, 3.알림옵션, 4.덱이름(수정포함),5.덱 카드들(컬렉션뷰 한줄 가로뷰)?, 6.일기들
//섹션이나 뷰를 두개로 나눈다. 1~5 6~9번 6번만 컬렉션뷰로
//일기셀: 날짜, 날씨?, 질문, 내용. 클릭시 뒤집기로 내용보기, 버튼으로 크게보기 or 클릭시 크게보기
//7.보기옵션: 카드 앞면보기, 뒷면보기, 같이보기, 리스트로보기
//8.정렬: 최신부터, 처음부터, 카드별
// 9.필터: 카드별, 기간으로 검색 -> 업데이트로 빼도...
//새일기 쓰기, 일기장 수정, 유저디폴트로 이니셜뷰 설정.

final class BookView: BaseView {
   
    let bookDetailView = BookDetailView()
   
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
        
        [collectionView, bookDetailView ].forEach {addSubview($0)}
    }
    
    override func setConstraints() {
        super.setConstraints()
        bookDetailView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(100)
        }
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(bookDetailView.snp.bottom).offset(8)
            make.bottom.equalToSuperview()
        }
    }
}
