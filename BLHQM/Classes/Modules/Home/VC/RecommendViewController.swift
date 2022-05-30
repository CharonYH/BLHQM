//
//  RecommendViewController.swift
//  BLHQM
//
//  Created by XiaoBai on 2022/5/15.
//

import UIKit
import JXSegmentedView
import Moya

private let space: CGFloat = 20
typealias RecPathFrom = HomeAPI
class RecommendViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        requestData()
        initUI()
    }
    
    // MARK: - public
    init(from path: RecPathFrom) {
        self.path = path
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - 数据相关
    private var path: RecPathFrom
    private var banners: [HomeItemModel] = []
    // banner底部的items
    private var iconItems: [HomeItemModel] = []
    // items下的数据
    private var moreItems: [HomeItemModel] = []
    
    /// 网络请求获取数据
    private func requestData() {
        let provider = MoyaProvider<HomeAPI>()
        provider.send(path, modelType: HomeBaseModel.self) { tjModel in
            if let tjModel = tjModel,
               let result = tjModel.result {
                self.banners = result.top_items
                self.iconItems = result.icon_items
                self.moreItems = result.more_items
                self.collectionView.reloadData()
                if self.path == .hb {
                    print("result = \(result)")
                }
            }
        }
    }

    // MARK: - UI相关
    private let bannerHeight = (KScreenWidth - 16.layoutFit * 2) * 0.5
    private var itemsHeight: CGFloat = 80//KScreenWidth * 0.224
    
    private func initUI() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.minimumLineSpacing = (space + 5) * RATIO_WIDHT750
        flowLayout.minimumInteritemSpacing = space
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // banner
        collectionView.register(RecBannerViewCell.self, forCellWithReuseIdentifier: "\(RecBannerViewCell.self)")
        // items
        collectionView.register(RecHeaderItemsViewCell.self, forCellWithReuseIdentifier: "\(RecHeaderItemsViewCell.self)")
        // headerView
        collectionView.register(RecHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(RecHeaderView.self)")
        // NormalCell（热门动画榜等）
        collectionView.register(RecNormalCell.self, forCellWithReuseIdentifier: "\(RecNormalCell.self)")
        // 阅读启蒙与表达等
        collectionView.register(RecListViewCell.self, forCellWithReuseIdentifier: "\(RecListViewCell.self)")
        // RecBigViewCell（宝宝都在看等）
        collectionView.register(RecBigViewCell.self, forCellWithReuseIdentifier: "\(RecBigViewCell.self)")
        // RecBigListViewCell（益智练习）
        collectionView.register(RecBigListViewCell.self, forCellWithReuseIdentifier: "\(RecBigListViewCell.self)")
        // RecSlideViewCell（我和恐龙交朋友等）
        collectionView.register(RecSlideViewCell.self, forCellWithReuseIdentifier: "\(RecSlideViewCell.self)")
        // RecSlideChildViewCell（读绘本）
        collectionView.register(RecSlideChildViewCell.self, forCellWithReuseIdentifier: "\(RecSlideChildViewCell.self)")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "\(UICollectionViewCell.self)")
        return collectionView
    }()
}

// MARK: UICollectionViewDataSource
extension RecommendViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // 2: banner + banner 下的item
        return moreItems.count + 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 || section == 1 {
            return 1
        }else {
            let model = moreItems[section - 2]
            switch model.layoutType {
            case .slide: return 1
            case .list:
                return min(model.viewP.itemCount + model.viewP.showHeader, 3)
            case .book:
                return max(model.viewP.itemCount + model.viewP.showHeader, 6)
            default:
                // 不超过4个
                return min(model.viewP.itemCount + model.viewP.showHeader, 4)
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let defaultCell = UICollectionViewCell()
        defaultCell.backgroundColor = RandomColor()
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(RecBannerViewCell.self)", for: indexPath) as? RecBannerViewCell else {
                return defaultCell
            }
            cell.bannerItems = banners
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(RecHeaderItemsViewCell.self)", for: indexPath) as? RecHeaderItemsViewCell else {
                return defaultCell
            }
            cell.items = iconItems
            return cell
        default:
            let model = moreItems[indexPath.section - 2]
            switch model.layoutType {
            case .hot:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(RecNormalCell.self)", for: indexPath) as? RecNormalCell else {
                    return defaultCell
                }
                cell.hotItem = model.data.items[indexPath.row]
                return cell
            case .list:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(RecListViewCell.self)", for: indexPath) as? RecListViewCell else {
                    return defaultCell
                }
                cell.listItem = model.data.items[indexPath.row]
                return cell
            case .big:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(RecBigViewCell.self)", for: indexPath) as? RecBigViewCell else {
                    return defaultCell
                }
                cell.bigItem = model.data.items[indexPath.row]
                return cell
            case .big_list:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(RecBigListViewCell.self)", for: indexPath) as? RecBigListViewCell else {
                    return defaultCell
                }
                cell.bigListItem = model.data.items[indexPath.row]
                return cell
            case .book:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(RecSlideChildViewCell.self)", for: indexPath) as? RecSlideChildViewCell else {
                    return defaultCell
                }
                cell.slideItem = model.data.items[indexPath.row]
                return cell
            case .slide:
                //RecSlideViewCell
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(RecSlideViewCell.self)", for: indexPath) as? RecSlideViewCell else {
                    return defaultCell
                }
                cell.slideItems = model.data.items
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(UICollectionViewCell.self)", for: indexPath)
                cell.backgroundColor = .lightGray
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let defaultView = UICollectionReusableView()
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(RecHeaderView.self)", for: indexPath) as? RecHeaderView else {
                 return defaultView
             }
            switch indexPath.section {
            case 0,1:
                headerView.item = nil
                return headerView
            default:
                let model = moreItems[indexPath.section - 2]
                headerView.item = model
                return headerView
            }
        }
        return defaultView
    }
}

// MARK: UICollectionViewDelegate
extension RecommendViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
   
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension RecommendViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section == 0 || section == 1 {
            return (space + 5) * RATIO_WIDHT750
        }else {
            let model = moreItems[section - 2]
            switch model.layoutType {
            case .list:
                return 1*RATIO_WIDHT750
            case .big_list:
                return 1*RATIO_WIDHT750
            case .book:
                return 15*RATIO_WIDHT750
            default:
                return (space + 5) * RATIO_WIDHT750
            }
        }
    }
    // item的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0: return .init(width: KScreenWidth - space * 2, height: banners.isEmpty ? 0 : bannerHeight)
        case 1: return .init(width: KScreenWidth - space * 2, height: iconItems.isEmpty ? 0 : itemsHeight)
        default:
            let model = moreItems[indexPath.section - 2]
            switch model.layoutType {
            case .hot:
                let width = (KScreenWidth - space * 3) / 2
                if model.viewP.itemCount == 2 && model.viewP.showHeader == 1 {
                    if indexPath.row == 0 {
                        let width1 = KScreenWidth - space * 2
                        return .init(width: width1, height: width1 * 9 / 16 + 25*RATIO_WIDHT750)
                    }else {
                        return .init(width: width, height: width * 9 / 16 + 25*RATIO_WIDHT750)
                    }
                }
                return .init(width: width, height: width * 9 / 16 + 25*RATIO_WIDHT750)
            case .big:
                let width = KScreenWidth - space * 2
                return .init(width: width, height: width * 9 / 16 + 25*RATIO_WIDHT750)
            case .list:
                let width = KScreenWidth - space * 2
                return .init(width: width, height: width * 8 / 26)
            case .big_list:
                let width = KScreenWidth - space * 2
                return .init(width: width, height: width * 9 / 17)
            case .book:
                let width = (KScreenWidth - space * 4) / 3
                return CGSize(width: width, height: width * 5 / 4)
            case .slide:
                let height = (KScreenWidth - space * 2 - 30*RATIO_WIDHT750) / 3 - 5*RATIO_WIDHT750
                return .init(width: KScreenWidth, height: height * 5 / 4)
            default:
                let width = (KScreenWidth - space * 3) / 2
                return .init(width: width, height: width * 9 / 16 + 25*RATIO_WIDHT750)
            }
        }
    }
    // headerView
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 || section == 1 {
            return .init(width: 0.01, height: 0.01)
        }else {
            return .init(width: KScreenWidth, height: 44.layoutFit)
        }
    }
    // collection的section内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 0:
            return .init(top: banners.isEmpty ? 0 : 10.layoutFit, left: 16.layoutFit, bottom: 0, right: 16.layoutFit)
        case 1:
            return .init(top: iconItems.isEmpty ? 0 : 10.layoutFit, left: 16.layoutFit, bottom: 0, right: 16.layoutFit)
        default:
            let model = moreItems[section - 2]
            switch model.layoutType {
            case .slide:
                return UIEdgeInsets(top: 10.layoutFit, left: 0, bottom: 10.layoutFit, right: 0)
            default:
                return UIEdgeInsets(top: 10.layoutFit, left: 16.layoutFit, bottom: 10.layoutFit, right: 16.layoutFit)
            }
        }
    }
    
}
// MARK: - JXSegmentedListContainerViewListDelegate
extension RecommendViewController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}

