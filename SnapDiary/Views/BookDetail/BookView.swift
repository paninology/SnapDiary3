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
       let view = UICollectionView()
        return view
    }()
    
    override func configure() {
        super.configure()
        [bookDetailView, collectionView].forEach {addSubview($0)}
    }
    
    override func setConstraints() {
        super.setConstraints()
        bookDetailView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(bookDetailView.snp.bottom).offset(8)
        }
    }
}
