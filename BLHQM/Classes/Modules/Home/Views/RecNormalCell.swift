//
//  RecNormalCell.swift
//  BLHQM
//
//  Created by XiaoBai on 2022/5/17.
//

import UIKit

/// icon + 底部lbl + bottomView（peopleCountLbl + countLbl）
class RecNormalCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: UI相关
    private func initUI() {
        
    }
    /// 图片
    private lazy var iconImgView: UIImageView = {
        let iconImgView = UIImageView(frame: .zero)
        return iconImgView
    }()
    /// 图片底部文字
    private lazy var titleLbl: UILabel = {
        let titleLbl = UILabel(frame: .zero)
        titleLbl.text = "超级汽车第二季"
        return titleLbl
    }()
    /// 图片中的底部的容器view
    /// 容器view右侧的UILabel
}
