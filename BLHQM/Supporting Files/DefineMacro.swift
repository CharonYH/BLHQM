//
//  DefineMacro.swift
//  EasyToLearn
//
//  Created by YEHAN on 2021/7/3.
//

import UIKit

//frame
let KScreenSize   = UIScreen.main.bounds
let KScreenWidth  = KScreenSize.size.width
let KScreenHeight = KScreenSize.size.height


//适配布局常用内联函数和宏
//状态栏高度
func Status_Bar_Height() -> CGFloat {
    
    if #available(iOS 11.0,*) {
        let keyWindow = UIApplication.shared.windows.first
        return keyWindow!.safeAreaInsets.top
    }else{
        return 20.0
    }
}

//导航栏高度
let Navigation_Bar_Height:CGFloat = 44.0

//状态栏+导航栏高度
func Status_And_Navigation_Height() ->CGFloat {
    return Status_Bar_Height() + Navigation_Bar_Height
}

//TabBar高度
let TabBar_Height:CGFloat = 49.0

//底部安全区域高度34.0f
func Bottom_Safe_Height() -> CGFloat {
    
    if #available(iOS 11.0,*) {
        let mainView = UIApplication.shared.windows.first
        return mainView!.safeAreaInsets.bottom
    }else{
        return 0.0
    }
}

//TabBar+安全区域高度
func TabBar_And_Bottom_Safe_Height() -> CGFloat {
    
    return Bottom_Safe_Height() + TabBar_Height
}

//屏幕适配计算,用于Masonry布局页面，%百分比适配布局比例计算
let RATIO_WIDHT750  = UIScreen.main.bounds.size.width / 375.0
let RATIO_HEIGHT750 = UIScreen.main.bounds.size.height - Status_And_Navigation_Height() - TabBar_And_Bottom_Safe_Height() / (667.0-64-49)
 
// 系统颜色
let KBlackColor     = UIColor.black         //黑色
let KDarkGrayColor  = UIColor.darkGray      //深灰色
let KLightGrayColor = UIColor.lightGray     //浅灰色
let KWhiteColor     = UIColor.white         //白色
let KGrayColor      = UIColor.gray          //灰色
let KRedColor       = UIColor.red           //红色
let KGreenColor     = UIColor.green         //绿色
let KBlueColor      = UIColor.blue          //蓝色
let KCyanColor      = UIColor.cyan          //青色
let KYellowColor    = UIColor.yellow        //黄色
let KMagentaColor   = UIColor.magenta       //洋红色或品红色
let KOrangeColor    = UIColor.orange        //橙色
let KPurpleColor    = UIColor.purple        //紫色
let KBrownColor     = UIColor.brown         //棕色
let KClearColor     = UIColor.clear         //透明色

//十六进制颜色
func RGBColorHex(s: Int) -> UIColor {
    
    return RGBColor(r: CGFloat(((s)>>16) & 0xFF), g: CGFloat(((s)>>8) & 0xFF), b: CGFloat((s) & 0xFF))
}

//RGB颜色
func RGBColor(r: CGFloat,g: CGFloat, b: CGFloat) -> UIColor {
    
    return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: 1.0)
}
//RGBRandomColor
func RGBRandomColor() -> UIColor {
    
    return UIColor(red: CGFloat(arc4random_uniform(256))/255.0, green: CGFloat(arc4random_uniform(256))/255.0, blue: CGFloat(arc4random_uniform(256))/255.0, alpha: 1.0)
}

func RGBA(r: CGFloat,g: CGFloat, b: CGFloat,a: CGFloat) -> UIColor {
    
    return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: (a)/255.0)
}

func RGB(r: CGFloat,g: CGFloat, b: CGFloat) -> UIColor {
    
    return RGBA(r: r, g: g, b: b, a: 1.0)
}

func RGB3(v: CGFloat) -> UIColor {
    
    return RGB(r: v, g: v, b: v)
}

func RandomColor() -> UIColor {
    
    return UIColor(red: CGFloat(arc4random_uniform(256))/255.0, green: CGFloat(arc4random_uniform(256))/255.0, blue: CGFloat(arc4random_uniform(256))/255.0, alpha: 1.0)
        //RGB(r: CGFloat(arc4random_uniform(256))/255.0, g: CGFloat(arc4random_uniform(256))/255.0, b: CGFloat(arc4random_uniform(256))/255.0)
}

//字体设置
func BoldSystemFont(fontSize: CGFloat) -> UIFont {
    
    return UIFont.boldSystemFont(ofSize: fontSize)
}

func SystemFont(fontSize: CGFloat) -> UIFont {
    
    return UIFont.systemFont(ofSize: fontSize)
}

func Font(name: String, fontSize: CGFloat) -> UIFont {
    
    return UIFont.init(name: name, size: fontSize)!
}

//苹方字体
func APP_PF_BOLD_FONT(fontSize: CGFloat) -> UIFont {
    
    return UIFont.init(name: "PingFangSC-Semibold", size: fontSize)!
}

func APP_PF_MEDIUM_FONT(fontSize: CGFloat) -> UIFont {
    
    return UIFont.init(name: "PingFangSC-Medium", size: fontSize)!
}

func APP_PF_LIGHT_FONT(fontSize: CGFloat) -> UIFont {
    
    return UIFont.init(name: "PingFangSC-Light", size: fontSize)!
}

func APP_PF_REGULAR_FONT(fontSize: CGFloat) -> UIFont{
    
    return UIFont.init(name: "PingFangSC-Regular", size: fontSize)!
}

func APP_PF_SEMIBOLD_FONT(fontSize: CGFloat) -> UIFont {
    
    return UIFont.init(name: "PingFangSC-Semibold", size: fontSize)!
}


//当前系统版本
func CURRENT_IOS_VERSION() -> Float {

    return Float(UIDevice.current.systemVersion)!
}

////国际化
func NSLocString(key: String,comment: String) -> String {
    
    return Bundle.main.localizedString(forKey: key, value: "", table: nil)
}

/**
 
 - Parameters:
 - message: 打印内容
 - fileName: 文件名
 - methodName: 方法名
 - lineNumber: 所在行数
 */
func YHLog<T>(message: T,
              fileName: String = #file,
              methodName: String = #function,
              lineNumber: Int = #line) {

    #if DEBUG
        let arr = fileName.components(separatedBy: "/")
        print("\(arr.last!) - \(methodName)[\(lineNumber)]:\(message)")
    #endif
    //class: <0x7fe11640bd60 YHRunnerViewController.m:(34) > method: -[YHRunnerViewController viewDidLoad]
   
}

//状态栏颜色
//func setStatusBarLightContent(isNeedLight: Bool) -> Void {
//
//    let app = UIApplication.shared
//    if isNeedLight {
//        if app.statusBarStyle == UIStatusBarStyle.default {
//            app.statusBarStyle = .lightContent
//        }else{
//            if app.statusBarStyle == .lightContent {
//                app.statusBarStyle = .default
//            }
//        }
//    }
//}
    
//YHUserDefaults
let YHUserDefaults = UserDefaults.standard
let GlobalQueue    = DispatchQueue.global()

/// 创建类
func YHClassFromString(aClassName: String) -> AnyClass?{
    func getAppName() -> String {
        guard let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String else { return ""}
        return appName
    }
    if let cls = NSClassFromString(getAppName() + "." + aClassName) {
        return cls
    }
    return nil
}
