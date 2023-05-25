//
//  NewBookView.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/05/24.
//

import UIKit


//새일기장: 제목, 알림옵션, 질문덱선택(설정), 사진
final class AddBookView: BaseView {
    
    let tableView: UITableView = {
        let view = UITableView(frame:CGRect() , style: .grouped)
//        view.backgroundColor = .red
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        super.configure()
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
