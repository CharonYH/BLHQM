//
//  RecSlideChildViewCell.swift
//  BLHQM
//
//  Created by XiaoBai on 2022/5/29.
//

import UIKit

class RecSlideChildViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    var slideItem: HomeItemChildDatas = .init() {
        didSet {
            iconImgView.yh_setImage(with: slideItem.image)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: UI相关
    private func initUI() {
        contentView.addSubview(iconImgView)
        iconImgView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }
    private lazy var iconImgView: UIImageView = {
        let iconImgView = UIImageView(frame: .zero)
        iconImgView.layer.cornerRadius = 8*RATIO_WIDHT750
        iconImgView.layer.masksToBounds = true
        return iconImgView
    }()
}
