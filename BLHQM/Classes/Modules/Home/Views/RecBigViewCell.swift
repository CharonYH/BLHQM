//
//  RecBigViewCell.swift
//  BLHQM
//
//  Created by XiaoBai on 2022/5/29.
//

import UIKit

class RecBigViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var bigItem: HomeItemChildDatas = .init() {
        didSet {
            iconImgView.yh_setImage(with: bigItem.image)
            titleLbl.text = bigItem.saleTitle
            if bigItem.count == bigItem.totalCount {
                countLbl.text = "共\(bigItem.totalCount)集"
            }else {
                countLbl.text = "更新至\(bigItem.count)/\(bigItem.totalCount)集"
            }
        }
    }
    //MARK: UI相关
    private func initUI() {
        contentView.addSubview(iconImgView)
        iconImgView.addSubview(iconBottomView)
        iconBottomView.addSubview(countLbl)
        contentView.addSubview(bottomWhiteView)
        bottomWhiteView.addSubview(titleLbl)
//        bottomWhiteView.addSubview(viewDetailBtn)
        
        iconImgView.snp.makeConstraints { make in
            make.top.left.right.equalTo(0)
            make.height.equalTo(contentView.snp.height).multipliedBy(0.75)
        }
        iconBottomView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(17*RATIO_WIDHT750)
        }
        countLbl.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-20*RATIO_WIDHT750)
        }
        bottomWhiteView.snp.makeConstraints { make in
            make.top.equalTo(iconImgView.snp.bottom)
            make.left.right.bottom.equalTo(0)
        }
        titleLbl.snp.makeConstraints { make in
            make.left.equalTo(30*RATIO_WIDHT750)
            make.top.equalTo(10*RATIO_WIDHT750)
        }
//        viewDetailBtn.snp.makeConstraints { make in
//            make.right.equalTo(-25*RATIO_WIDHT750)
//            make.bottom.equalTo(-10*RATIO_WIDHT750)
//            make.size.equalTo(CGSize(width: 100*RATIO_WIDHT750, height: 21*RATIO_WIDHT750))
//        }
    }
    /// 图片
    private lazy var iconImgView: UIImageView = {
        let iconImgView = UIImageView(frame: .zero)
        iconImgView.layer.cornerRadius = 8*RATIO_WIDHT750
        iconImgView.layer.masksToBounds = true
        iconImgView.image = UIColor.lightGray.image()
        return iconImgView
    }()
    /// 图片中的底部的容器view
    private lazy var iconBottomView: UIView = {
        let iconBottomView = UIView(frame: .zero)
        iconBottomView.backgroundColor = .black.withAlphaComponent(0.2)
        return iconBottomView
    }()
    /// 容器view右侧的UILabel
    private lazy var countLbl: UILabel = {
        let countLbl = UILabel(frame: .zero)
        countLbl.text = "共52集"
        countLbl.textColor = .white
        countLbl.font = .systemFont(ofSize: 11,weight: .medium)
        return countLbl
    }()
    // 底部白色的容器view
    private lazy var bottomWhiteView: UIView = {
        let bottomWhiteView = UIView(frame: .zero)
        return bottomWhiteView
    }()
    // 标题
    private lazy var titleLbl: UILabel = {
        let titleLbl = UILabel(frame: .zero)
        titleLbl.text = ""
        titleLbl.numberOfLines = 0
        titleLbl.font = .systemFont(ofSize: 18,weight: .bold)
        return titleLbl
    }()
    private lazy var viewDetailBtn: UIButton = {
        let viewDetailBtn = UIButton(frame: .zero)
        viewDetailBtn.backgroundColor = RGBColorHex(s: 0xf3ba40)
        viewDetailBtn.layer.cornerRadius = 8*RATIO_WIDHT750
        viewDetailBtn.layer.masksToBounds = true
        viewDetailBtn.setTitle("点击查看详情", for: .normal)
        viewDetailBtn.setTitleColor(.white, for: .normal)
        viewDetailBtn.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        viewDetailBtn.setImage(.init(named: "blh_right_narrow"), for: .normal)
        viewDetailBtn.imagePositon(.right, space: 1*RATIO_WIDHT750)
        return viewDetailBtn
    }()
}
