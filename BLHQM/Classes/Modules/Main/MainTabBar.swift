//
//  MainTabBar.swift
//  BLHDemo
//
//  Created by XiaoBai on 2022/5/14.
//

import UIKit

class MainTabBar: UITabBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
//        isTranslucent = false
//        backgroundImage = UIImage.imageWithColor(color: UIColor.white, size: CGSize(width: UIScreen.main.bounds.width, height: 49))
//        shadowImage = UIImage.imageWithColor(color: RGBColorHex(s: 0xF4F4F4), size: CGSize(width: 1, height: 1))
        customView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateVIPImageView(_ isSelected: Bool) {
        vipImgView.image = isSelected ? R.image.tabbar_vip_selected()  : R.image.tabbar_vip_normal()
    }
    //MARK: 填充View
    private func customView() {
        addSubview(backgroundImgView)
        backgroundImgView.addSubview(vipImgView)
        layoutSubViews()
    }
    override func layoutSubviews() {
        super.layoutSubviews()

        // 不知道为什么切出后台再会应用该方法会走多次 所以必须得每次更新
        backgroundImgView.center = .init(x: center.x, y: 20*RATIO_WIDHT750)
    }
    //MARK: 适配View
    private func layoutSubViews() {
        vipImgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-18*RATIO_WIDHT750)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
    }
    
    //MARK: 懒加载
    private lazy var backgroundImgView: UIImageView = {
        let backgroundImgView = UIImageView(frame: .init(x: 0, y: 0, width: (KScreenWidth - 20) / 5 - 10, height: 61*RATIO_WIDHT750))
        backgroundImgView.image = R.image.tabbar_middlebulge_backImg()
        return backgroundImgView
    }()
    private lazy var vipImgView: UIImageView = {
        let vipImgView = UIImageView(frame: .zero)
        vipImgView.image = R.image.tabbar_vip_normal()
        vipImgView.contentMode = .scaleAspectFit
        return vipImgView
    }()
    
}
