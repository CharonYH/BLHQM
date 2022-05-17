//
//  HeaderItemViewCell.swift
//  BLHQM
//
//  Created by XiaoBai on 2022/5/17.
//

import UIKit

class RecHeaderItemViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func initUI() {
        contentView.addSubview(imgView)
        contentView.addSubview(titleLbl)
        imgView.snp.makeConstraints { make in
            make.top.left.right.equalTo(0)
            make.height.equalTo(imgView.snp.width)
        }
        titleLbl.snp.makeConstraints { (make) in
            make.top.equalTo(imgView.snp.bottom)
            make.centerX.equalToSuperview()
        }
    }
    // MARK: - properties
    private lazy var imgView: UIImageView = {
        let imgView = UIImageView(frame: .zero)
        imgView.image = UIColor.lightGray.image()
        return imgView
    }()
    private lazy var titleLbl: UILabel = {
        let titleLbl = UILabel(frame: .zero)
        titleLbl.text = "学童谣"
        titleLbl.textColor = RGBColorHex(s: 0x666666)
        titleLbl.textAlignment = .center
        titleLbl.font = .systemFont(ofSize: 12)
        return titleLbl
    }()
}
