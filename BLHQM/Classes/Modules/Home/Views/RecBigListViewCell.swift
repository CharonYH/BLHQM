//
//  RecBigListViewCell.swift
//  BLHQM
//
//  Created by XiaoBai on 2022/5/29.
//

import UIKit

class RecBigListViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var bigListItem: HomeItemChildDatas = .init() {
        didSet {
            iconImgView.yh_setImage(with: bigListItem.image23x8)
        }
    }
    //MARK: UI相关
    private func initUI() {
        contentView.addSubview(backgroundImgView)
        backgroundImgView.addSubview(iconImgView)
        
        backgroundImgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        iconImgView.snp.makeConstraints { make in
            make.top.equalTo(5*RATIO_WIDHT750)
            make.left.equalTo(5*RATIO_WIDHT750)
            make.right.equalTo(-5*RATIO_WIDHT750)
            make.height.equalTo(backgroundImgView.snp.height).multipliedBy(0.667)
        }
    }
    
    private lazy var iconImgView: UIImageView = {
        let iconImgView = UIImageView(frame: .zero)
        iconImgView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        iconImgView.layer.cornerRadius = 8*RATIO_WIDHT750
        iconImgView.clipsToBounds = true
        return iconImgView
    }()
    private lazy var backgroundImgView: UIImageView = {
        let backgroundImgView = UIImageView(frame: .zero)
        backgroundImgView.image = .init(named: "blh_cell_img1")
        backgroundImgView.clipsToBounds = true
        return backgroundImgView
    }()
    private lazy var bottomWhiteView: UIView = {
        let bottomWhiteView = UIView(frame: .zero)
        bottomWhiteView.backgroundColor = .white
        bottomWhiteView.layer.shadowColor = RGBColorHex(s: 0x999999).cgColor
        bottomWhiteView.layer.shadowOffset = .init(width: 0, height: 2*RATIO_WIDHT750)
        bottomWhiteView.layer.shadowOpacity = 1
        bottomWhiteView.backgroundColor = .gray
        return bottomWhiteView
    }()
}
