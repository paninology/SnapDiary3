//
//  BookListView.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/05/22.
//

import UIKit

final class BookListView: BaseView {
    
    let collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        
        func createLayout() -> UICollectionViewLayout {
            //14+ 컬렉션뷰를 테이블뷰 스타일처럼 사용 가능 ( List configuration)
            var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
            configuration.showsSeparators = false
            configuration.backgroundColor = .brown            
            let layout = UICollectionViewCompositionalLayout.list(using: configuration)
            return layout
        }
        
        return view
    }()
    override func configure() {
        super.configure()
        addSubview(collectionView)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    
    
}
