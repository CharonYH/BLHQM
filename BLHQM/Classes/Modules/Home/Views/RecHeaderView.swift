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
            initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func moreBtnClick() {
        moreBtnClickHandler?()
    }
    var item: HomeItemModel?{
        didSet {
            titleLbl.text = item?.title ?? ""
            moreBtn.isHidden = !((item?.viewP.itemCount ?? 0) > 4)
        }
    }
    /// 按钮点击
    var moreBtnClickHandler: (() -> ())?
    
    // MARK: - initUI
    private func initUI() {
        addSubview(titleLbl)
        addSubview(moreBtn)
        
        titleLbl.snp.makeConstraints { make in
            make.bottom.equalTo(0*RATIO_WIDHT750)
            make.left.equalTo(16.layoutFit)
        }
        moreBtn.snp.makeConstraints { make in
            make.right.equalTo(-20*RATIO_WIDHT750)
            make.centerY.equalTo(titleLbl)
        }
    }
    private lazy var titleLbl: UILabel = {
        let titleLbl = UILabel(frame: .zero)
        titleLbl.textAlignment = .left
        titleLbl.textColor = .black
        titleLbl.font = .init(name: "FZY4JW--GB1-0", size: 21)//.systemFont(ofSize: 20)
        return titleLbl
    }()
    private lazy var moreBtn: UIButton = {
        let moreBtn = UIButton(frame: .zero)
        moreBtn.isHidden = true
        moreBtn.setTitleColor(RGBColorHex(s: 0x999999), for: .normal)
        moreBtn.setTitle("更多", for: .normal)
        moreBtn.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
        moreBtn.setImage(.init(named: "blh_right_narrow"), for: .normal)
        moreBtn.imagePositon(.right, space: 1*RATIO_WIDHT750)
        return moreBtn
    }()
}
