//
//  RecommendViewController.swift
//  BLHQM
//
//  Created by XiaoBai on 2022/5/15.
//

import UIKit
import JXSegmentedView
import Moya

private let space: CGFloat = 16

class RecommendViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        requestData()
        initUI()
    }
    
    // MARK: - public

    // MARK: - 数据相关
    private var banners: [HomeItemModel] = []
    // banner底部的items
    private var topItems: [HomeItemModel] = []
    // items下的数据
    private var dataSource: [HomeItemModel] = []
    
    private func requestData() {
        let provider = MoyaProvider<HomeAPI>()
        provider.send(.tj, modelType: HomeTjModel.self) { tjModel in
            if let tjModel = tjModel,
               let result = tjModel.result {
                self.banners = result.top_items
                self.topItems = result.icon_items
                self.dataSource = result.more_items
                self.collectionView.reloadData()
            }
        }
    }

    // MARK: - UI相关
    private let bannerHeight = (KScreenWidth - space * 2) * 0.5
    private var itemsHeight = KScreenWidth * 0.224
    
    private func initUI() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
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
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "\(UICollectionViewCell.self)")
        return collectionView
    }()
}

// MARK: UICollectionViewDataSource
extension RecommendViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // 2: banner + banner 下的item
        return dataSource.count + 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 || section == 1 {
            return 1
        }else {
            let model = dataSource[section - 2]
            switch model.layoutType {
            case .slide: return 1
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
            
            cell.backgroundColor = .lightGray
            return cell
        default:
            let model = dataSource[indexPath.section - 2]
            switch model.layoutType {
//            case .hot:
//
//                break
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(UICollectionViewCell.self)", for: indexPath)
                cell.backgroundColor = .lightGray
                return cell
//            case .big:
//                <#code#>
//            case .video:
//                <#code#>
//            case .big_list:
//                <#code#>
//            case .slide:
//                <#code#>
//            case .book:
//                <#code#>
//            case .store:
//                <#code#>
//            case .store_list:
//                <#code#>
//            case .vip:
//                <#code#>
//            case .video_player:
//                <#code#>
//            case .audio_list:
//                <#code#>
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let defaultView = UICollectionReusableView()
        if kind == UICollectionView.elementKindSectionHeader {
            switch indexPath.section {
            case 0,1:
                guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(RecHeaderView.self)", for: indexPath) as? RecHeaderView else {
                     return defaultView
                 }
                headerView.backgroundColor = RandomColor()
                return headerView
            default:
                guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(RecHeaderView.self)", for: indexPath) as? RecHeaderView else {
                     return defaultView
                 }
                headerView.backgroundColor = RandomColor()
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        if section == 0 || section == 1 {
//            return 0
//        }
//        let model = dataSource[section - 2]
//        if model.viewP.itemCount == 2 && model.viewP.showHeader == 1 {
//            return space
//        }
        return space
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return space
    }
    // item的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0: return .init(width: KScreenWidth - space * 2, height: bannerHeight)
        case 1: return .init(width: KScreenWidth - space * 2, height: itemsHeight)
        default:
            let model = dataSource[indexPath.section - 2]
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
                return .init(width: width, height: width * 8 / 23)
            case .big_list:
                let width = KScreenWidth - space * 2
                return .init(width: width, height: width * 8 / 23)
            case .slide:
                let height = (KScreenWidth - space * 2 - 30*RATIO_WIDHT750) / 3 - 5*RATIO_WIDHT750
                return .init(width: KScreenWidth, height: height * 5 / 4)
//            case .book:
//                let width = (KScreenWidth - space * 4) / 3
//                return .init(width: width, height: width * 5 / 4)
//            case .store:
//                let width = (KScreenWidth - space * 4) / 3
//                return .init(width: width, height: width)
//            case .store_list:
//                let height = (KScreenWidth - space * 4) / 3
//                return .init(width: KScreenWidth - space, height: height)
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
    // collection的section之间的间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 0:
            return .init(top: 10.layoutFit, left: space, bottom: 0, right: space)
        case 1:
            return .init(top: 10.layoutFit, left: space, bottom: 0, right: space)
        default:
            let model = dataSource[section - 2]
            switch model.layoutType {
            case .slide:
                return UIEdgeInsets(top: 10.layoutFit, left: 0, bottom: 10.layoutFit, right: 0)
            default:
                return UIEdgeInsets(top: 10.layoutFit, left: space, bottom: 10.layoutFit, right: space)
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

