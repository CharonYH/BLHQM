//
//  MainTableViewController.swift
//  BLHDemo
//
//  Created by XiaoBai on 2022/5/14.
//

import UIKit

class MainTableViewController: UITabBarController {

    private lazy var mainTabBar = MainTabBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        setValue(mainTabBar, forKey: "tabBar")
        createChildViewControllers()
        configShadowColor()
//        configTabBarItemAttributes()
    }
    
    /// 添加子控制器
    /// - Parameters:
    ///   - controller: UIViewController
    ///   - title: 标题
    ///   - image: 未选中下图片
    ///   - selectedImage: 选中下图片
    private func addChildViewController(
        _ controller: UIViewController,
               title: String,
               image: UIImage?,
       selectedImage: UIImage?) {
           
           let nav = BaseNavigationController(rootViewController: controller)
           nav.tabBarItem.title = title
           nav.tabBarItem.image = image
           nav.tabBarItem.selectedImage = selectedImage
           
           nav.tabBarItem.setTitleTextAttributes([.foregroundColor:RGBColorHex(s: 0x999999),.font:UIFont.systemFont(ofSize: 10)], for: .normal)
           nav.tabBarItem.setTitleTextAttributes([.foregroundColor:RGBColorHex(s: 0x4B350D),.font:UIFont.systemFont(ofSize: 10)], for: .selected)
           if #available(iOS 13.0, *) {
               tabBar.unselectedItemTintColor = UIColor.black
           }
           addChild(nav)
    }
    
    /// 添加所有的子控制器
    private func createChildViewControllers() {
        let homeVC = HomeViewController()
        addChildViewController(homeVC,
                               title: "首页",
                               image: R.image.tabbar_home_normal(),
                               selectedImage: R.image.tabbar_home_selected())
        
        let schoolVC = SchoolViewController()
        addChildViewController(schoolVC,
                               title: "学堂",
                               image: R.image.tabbar_course_normal(),
                               selectedImage: R.image .tabbar_course_selected())
        
        let vipVC = VIPViewController()
        addChildViewController(vipVC,
                               title: "VIP",
                               image: nil,
                       selectedImage: nil)
        
        let growthVC = GrowthParadiseViewController()
        addChildViewController(growthVC,
                               title: "成长乐园",
                               image: R.image.tabbar_daka_normal(),
                               selectedImage: R.image.tabbar_daka_selected())
        
        let mineVC = HomeViewController()
        addChildViewController(mineVC,
                               title: "我的",
                               image: R.image.tabbar_me_normal(),
                               selectedImage: R.image.tabbar_me_selected())
    }
    /// 配置tabBarItem属性
    private func configTabBarItemAttributes() {
        // Key: UIKit->NSAttributedString.Key
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor:RGBColorHex(s: 0x999999),.font:UIFont.systemFont(ofSize: 10)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor:RGBColorHex(s: 0x4B350D),.font:UIFont.systemFont(ofSize: 10)], for: .selected)
        if #available(iOS 13.0, *) {
            tabBar.unselectedItemTintColor = UIColor.black
        }
    }
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        mainTabBar.updateVIPImageView(item.title == "VIP")
    }
}

extension MainTableViewController {
    
    /// 配置阴影偏移
    private func configShadowColor() {
        tabBar.layer.shadowColor = UIColor.lightGray.cgColor
        tabBar.layer.shadowOpacity = 0.3
        tabBar.backgroundImage = UIImage()
        tabBar.backgroundColor = .white
    }
}
