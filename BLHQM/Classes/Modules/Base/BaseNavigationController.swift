//
//  BaseNavigationController.swift
//  BLHDemo
//
//  Created by Charron on 2021/8/31.
//

import UIKit

class BaseNavigationController: UINavigationController {

    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}
