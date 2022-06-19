//
//  UIView+Extension.swift
//  TMDB Orange
//
//  Created by Administrator  on 19/06/22.
//

import UIKit.UIView

extension UIView {

    func allSubviews() -> [UIView] {
        var allSubviews = subviews
        for subview in subviews {
            allSubviews.append(contentsOf: subview.allSubviews())
        }
        return allSubviews
    }
}
