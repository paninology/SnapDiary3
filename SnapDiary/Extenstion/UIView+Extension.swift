//
//  UIView+Extension.swift
//  SnapDiary
//
//  Created by yongseok lee on 2023/06/20.
//

import UIKit

extension UIView {
    func makeRoundLayer(bgColor: UIColor) {
        layer.cornerRadius = 8
        clipsToBounds = true
        backgroundColor = bgColor
    }
}
