//
//  RecHeaderView.swift
//  BLHQM
//
//  Created by XiaoBai on 2022/5/17.
//

import UIKit

class RecHeaderView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: .zero)
            backgroundColor = RandomColor()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
