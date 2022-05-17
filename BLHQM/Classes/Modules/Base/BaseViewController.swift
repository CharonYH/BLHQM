//
//  BaseViewController.swift
//  BLHDemo
//
//  Created by Charron on 2021/8/31.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    //MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(isNavigationBarHidden, animated: animated)
    }
    
    //MARK: 导航栏相关
    /// 是否去掉导航栏的下划线
    func removeNavigationBarBottomLine() {
        navigationController?.navigationBar.setBackgroundImage(.init(), for: .default)
        navigationController?.navigationBar.shadowImage = .init()
    }
    
    /// 是否隐藏当前的导航栏
    var isNavigationBarHidden: Bool {
        return true
    }

    /// 启用返回手势
    func configPopRecognizer() {
        navigationController?.navigationBar.barTintColor = view.backgroundColor
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    /// 返回
    @objc func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    /// 配置返回按钮
    func configBackBarItem() {
        let backBarItem = UIBarButtonItem(image: .init(named: "navigation_back_black"), style: .done, target: self, action: #selector(popViewController))
        navigationItem.leftBarButtonItem = backBarItem
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
}


//MARK: 恢复启用手势返回
extension BaseViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return navigationController?.viewControllers.count ?? 0 > 0
    }
}
