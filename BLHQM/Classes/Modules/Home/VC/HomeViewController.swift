//
//  HomeViewController.swift
//  BLHDemo
//
//  Created by XiaoBai on 2022/5/14.
//

import UIKit
import Moya
import JXSegmentedView
import MBProgressHUD

class HomeViewController: BaseViewController {

    private let provider = MoyaProvider<HomeAPI>()
    var topSegmentedTitles: [String] = ["推荐","识字启蒙","唱儿歌","看动画","读绘本","英语专区","汉语启蒙"]
    var controllers: [RecommendViewController] = [
        .init(from: .tj),
        .init(from: .szqm),
        .init(from: .eg),
        .init(from: .dh),
        .init(from: .hb),
        .init(from: .english),
        .init(from: .hyqm)]
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }

    // MARK: initUI
    private func initUI() {
        view.addSubview(segmentedView)
        view.addSubview(listContainerView)
        
        segmentedView.snp.makeConstraints { make in
            make.top.equalTo(Status_Bar_Height())
            make.left.right.equalTo(0)
            make.height.equalTo(Navigation_Bar_Height)
        }
        listContainerView.snp.makeConstraints { make in
            make.top.equalTo(segmentedView.snp.bottom).offset(0)
            make.left.right.equalTo(0)
            make.bottom.equalTo(-TabBar_And_Bottom_Safe_Height())
        }
    }
    // MARK: - lazy load
    /// 标题数据源
    private lazy var segmentedDataSource: JXSegmentedTitleDataSource = {
       let segmentedDataSource = JXSegmentedTitleDataSource()
        segmentedDataSource.itemWidthIncrement = 10*RATIO_WIDHT750
        segmentedDataSource.isTitleColorGradientEnabled = true
        segmentedDataSource.isItemSpacingAverageEnabled = false
        segmentedDataSource.titleNormalColor = RGBColorHex(s: 0x999999)
        segmentedDataSource.titleSelectedColor = RGBColorHex(s: 0x1F1F1F)
        segmentedDataSource.titleNormalFont = APP_PF_BOLD_FONT(fontSize: 17)
        segmentedDataSource.titleSelectedFont = APP_PF_BOLD_FONT(fontSize: 18)
        segmentedDataSource.titles = topSegmentedTitles
        return segmentedDataSource
    }()
    /// 配置指示器
    private lazy var indicator: JXSegmentedIndicatorLineView = {
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorWidth = 20*RATIO_WIDHT750
        indicator.indicatorColor = RGBColorHex(s: 0xFFE500)
        //指示条位置的偏移
        indicator.verticalOffset = 4*RATIO_WIDHT750
        return indicator
    }()
    
    /// 标题选择器
    open lazy var segmentedView: JXSegmentedView = {
        let segmentedView = JXSegmentedView(frame: .zero)
        //segmentedViewDataSource一定要通过属性强持有！！！！！！！！！
        segmentedView.dataSource = segmentedDataSource
        segmentedView.delegate = self
        segmentedView.listContainer = listContainerView
        segmentedView.indicators = [indicator]
        return segmentedView
    }()
    /// 标题下控制的容器
    open lazy var listContainerView: JXSegmentedListContainerView = {
        let listContainerView = JXSegmentedListContainerView(dataSource: self)
        return listContainerView
    }()
    
}

//// MARK: - JXSegmentedViewDelegate
extension HomeViewController: JXSegmentedViewDelegate {
    
}

// MARK: - JXSegmentedListContainerViewDataSource
extension HomeViewController: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        return topSegmentedTitles.count
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        return controllers[index] as JXSegmentedListContainerViewListDelegate
    }
}
