//
//  BannerCollectionViewCell.swift
//  BLHQM
//
//  Created by XiaoBai on 2022/5/17.
//

import UIKit
import FSPagerView
import Kingfisher
import SDWebImage
class RecBannerViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - 数据相关
    var bannerItems: [HomeItemModel] = [] {
        didSet {
            // 有数据就隐藏
            placeHolderImgView.isHidden = bannerItems.isEmpty
            pageControl.numberOfPages = bannerItems.count
            pagerView.reloadData()
        }
    }
    
    // MARK: - UI相关
    private func initUI() {
        contentView.addSubview(placeHolderImgView)
        contentView.addSubview(pagerView)
        contentView.addSubview(pageControl)
        
        placeHolderImgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-500*RATIO_WIDHT750)
            make.left.equalToSuperview().offset(-16*RATIO_WIDHT750)
            make.right.equalToSuperview().offset(16*RATIO_WIDHT750)
            make.height.equalTo(650*RATIO_WIDHT750)
        }
        pagerView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        pageControl.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(20*RATIO_WIDHT750)
        }
    }
    /// banner的占位图
    private lazy var placeHolderImgView: UIImageView = {
        let placeHolderImgView = UIImageView(frame: .zero)
        placeHolderImgView.image = R.image.banner_bg_yellow()
        placeHolderImgView.isHidden = true
        return placeHolderImgView
    }()
    private lazy var pagerView: FSPagerView = {
        let pagerView = FSPagerView(frame: .zero)
        // 自动滚动时间
        pagerView.automaticSlidingInterval = 3
        // 无限滚动（最后一张到第一张的过渡等）
        pagerView.isInfinite = true
        // 如果只有一张图片 就移除无限循环
        pagerView.removesInfiniteLoopForSingleItem = true
        pagerView.layer.cornerRadius = 8*RATIO_WIDHT750
        pagerView.layer.masksToBounds = true
        pagerView.itemSize = pagerView.frame.size
        // 不➕这句 效果有问题
//        pagerView.backgroundColor = .clear
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "\(FSPagerViewCell.self)")
        
        pagerView.delegate = self
        pagerView.dataSource = self
        return pagerView
    }()
    private lazy var pageControl: FSPageControl = {
        let pageControl = FSPageControl()
        pageControl.hidesForSinglePage = true
        pageControl.contentHorizontalAlignment = .center
        pageControl.setFillColor(.white, for: .selected)
        pageControl.setFillColor(RGBColorHex(s: 0x999999), for: .normal)
        pageControl.currentPage = 0
        pageControl.interitemSpacing = 12
        pageControl.backgroundColor = .clear
        return pageControl
    }()
}

// MARK: - FSPagerViewDataSource
extension RecBannerViewCell: FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return bannerItems.count
    }
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "\(FSPagerViewCell.self)", at: index)
        let model = bannerItems[index]
        var bannerURL = model.data.bannercover
        if bannerURL.isEmpty {
            bannerURL = model.viewP.focusUrl
        }
        if bannerURL.isEmpty,
           let itme = model.data.items.first {
            bannerURL = itme.image
        }
        cell.imageView?.sd_setImage(with: .init(string: bannerURL))
//        cell.imageView?.contentMode = .scaleAspectFill
        return cell
    }
}
// MARK:
extension RecBannerViewCell: FSPagerViewDelegate {
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        pageControl.currentPage = pagerView.currentIndex
    }
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        print("当前点击的bannerIndex = \(index)")
    }
}
