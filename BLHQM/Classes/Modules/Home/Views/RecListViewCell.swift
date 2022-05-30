//
//  RecListViewCell.swift
//  BLHQM
//
//  Created by XiaoBai on 2022/5/29.
//

import UIKit

class RecListViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var listItem: HomeItemChildDatas = .init() {
        didSet {
            iconImgView.yh_setImage(with: listItem.image)
            titleLbl.text = listItem.saleTitle
            if listItem.count == listItem.totalCount {
                countLbl.text = "共\(listItem.totalCount)集"
            }else {
                countLbl.text = "更新至\(listItem.count)/\(listItem.totalCount)集"
            }
        }
    }
    
    //MARK: UI相关
    private func initUI() {
        contentView.addSubview(iconImgView)
        contentView.addSubview(titleLbl)
        iconImgView.addSubview(bottomView)
        bottomView.addSubview(countLbl)
        iconImgView.snp.makeConstraints { make in
            make.top.left.equalTo(0)
            make.width.equalTo((KScreenWidth - 20 * 3) / 2)
            make.height.equalTo(iconImgView.snp.width).dividedBy(1.77777778)
        }
        bottomView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(17*RATIO_WIDHT750)
        }
        countLbl.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-20*RATIO_WIDHT750)
        }
        titleLbl.snp.makeConstraints { make in
            make.left.equalTo(iconImgView.snp.right).offset(15*RATIO_WIDHT750)
            make.right.equalTo(0*RATIO_WIDHT750)
            make.top.equalTo(iconImgView.snp.top).offset(10*RATIO_WIDHT750)
        }
    }
    private lazy var titleLbl: UILabel = {
        let titleLbl = UILabel(frame: .zero)
        titleLbl.text = ""
        titleLbl.numberOfLines = 0
        titleLbl.font = .systemFont(ofSize: 18,weight: .bold)
        return titleLbl
    }()
    /// 图片
    private lazy var iconImgView: UIImageView = {
        let iconImgView = UIImageView(frame: .zero)
        iconImgView.layer.cornerRadius = 8*RATIO_WIDHT750
        iconImgView.layer.masksToBounds = true
        iconImgView.image = UIColor.lightGray.image()
        return iconImgView
    }()
    /// 图片中的底部的容器view
    private lazy var bottomView: UIView = {
        let bottomView = UIView(frame: .zero)
        bottomView.backgroundColor = .black.withAlphaComponent(0.2)
        return bottomView
    }()
    /// 容器view右侧的UILabel
    private lazy var countLbl: UILabel = {
        let countLbl = UILabel(frame: .zero)
        countLbl.text = "共52集"
        countLbl.textColor = .white
        countLbl.font = .systemFont(ofSize: 11,weight: .medium)
        return countLbl
    }()
}
