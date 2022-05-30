//
//  AppDelegate.swift
//  BLHQM
//
//  Created by XiaoBai on 2022/5/14.
//

import UIKit
import IQKeyboardManager

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = .init(frame: UIScreen.main.bounds)
        window?.rootViewController = MainTableViewController()
        window?.makeKeyAndVisible()
        /// 配置IQKeyboardManager
        configIQKeyboard()
        return true
    }

}

extension AppDelegate {
    /// 配置IQKeyboardManager
    private func configIQKeyboard() {
        /// 禁用IQKeyboardManager键盘上方的toolBar
        IQKeyboardManager.shared().isEnableAutoToolbar = false
        /// 点击弹回键盘
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
    }
}
