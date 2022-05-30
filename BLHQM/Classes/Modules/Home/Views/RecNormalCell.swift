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
    
    var hotItem: HomeItemChildDatas = .init() {
        didSet {
            if hotItem.totalCount == 0 {
                titleLbl.text = hotItem.title
                iconImgView.yh_setImage(with: hotItem.image.prefix("@"))
                subTitleLbl.text = hotItem.desc
                bottomView.isHidden = true
            }else {
                iconImgView.yh_setImage(with: hotItem.bannercover)
                titleLbl.text = hotItem.subcatename
                subTitleLbl.text = hotItem.desc
                if hotItem.count == hotItem.totalCount {
                    countLbl.text = "共\(hotItem.totalCount)集"
                }else {
                    countLbl.text = "更新至\(hotItem.count)/\(hotItem.totalCount)集"
                }
            }
        }
    }
    func update(withBottomData hotItem: HomeItemChildDatas) {
        titleLbl.text = hotItem.subcatename
        subTitleLbl.text = hotItem.desc
        iconImgView.yh_setImage(with: hotItem.bannercover)
        if hotItem.count == hotItem.totalCount {
            countLbl.text = "共\(hotItem.totalCount)集"
        }else {
            countLbl.text = "更新至\(hotItem.count)/\(hotItem.totalCount)集"
        }
    }
    //MARK: UI相关
    private func initUI() {
        contentView.addSubview(iconImgView)
        contentView.addSubview(titleLbl)
        contentView.addSubview(subTitleLbl)
        iconImgView.addSubview(bottomView)
        bottomView.addSubview(countLbl)
        
        iconImgView.snp.makeConstraints { make in
            make.top.left.right.equalTo(0)
            make.height.equalTo(iconImgView.snp.width).dividedBy(1.77777778)
        }
        titleLbl.snp.makeConstraints { make in
            make.top.equalTo(iconImgView.snp.bottom).offset(7*RATIO_WIDHT750)
            make.left.right.equalTo(0)
        }
        subTitleLbl.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(4*RATIO_WIDHT750)
            make.left.right.equalTo(0)
        }
        bottomView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(17*RATIO_WIDHT750)
        }
        countLbl.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-20*RATIO_WIDHT750)
        }
    }
    /// 图片
    private lazy var iconImgView: UIImageView = {
        let iconImgView = UIImageView(frame: .zero)
        iconImgView.layer.cornerRadius = 8*RATIO_WIDHT750
        iconImgView.layer.masksToBounds = true
        iconImgView.image = UIColor.lightGray.image()
        return iconImgView
    }()
    /// 图片底部文字
    private lazy var titleLbl: UILabel = {
        let titleLbl = UILabel(frame: .zero)
        titleLbl.text = "超级汽车第二季"
        titleLbl.font = .systemFont(ofSize: 18,weight: .bold)
        return titleLbl
    }()
    /// 描述文字
    private lazy var subTitleLbl: UILabel = {
        let subTitleLbl = UILabel(frame: .zero)
        subTitleLbl.text = ""
        subTitleLbl.textColor = RGBColorHex(s: 0x999999)
        subTitleLbl.font = .systemFont(ofSize: 12)
        return subTitleLbl
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
