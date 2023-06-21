//
//  BookDetailView.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/06/21.
//
import UIKit
//1.일기장 제목, 2.설명, 3.알림옵션, 4.덱이름(수정포함),5.덱 카드들(컬렉션뷰 한줄 가로뷰)?
final class BookDetailView: BaseView {
    
    
    let title: UILabel = {
        let view = UILabel()
//        view.numberOfLines = 0
        return view
    }()
    //    let title
    let subtitle: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        return view
    }()
    
    let notiOption: UILabel = {
        let view = UILabel()
        return view
    }()
    let deckInfo: UILabel = {
        let view = UILabel()
        return view
    }()
    
    override func configure() {
        super.configure()
        [title, subtitle, notiOption, deckInfo].forEach { addSubview($0)}
    }
    override func setConstraints() {
        super.setConstraints()
        let margin = 8
        title.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(margin)
            make.top.equalToSuperview().inset(margin)
        }
        subtitle.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(margin)
            make.top.equalTo(title.snp.bottom).offset(margin)
        }
        notiOption.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(margin)
            make.top.equalTo(subtitle.snp.bottom).offset(margin)
        }
        deckInfo.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(margin)
            make.top.equalTo(notiOption.snp.bottom).offset(margin)
        }
    }
    
}
