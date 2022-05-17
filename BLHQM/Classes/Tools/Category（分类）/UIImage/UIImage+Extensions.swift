//
//  UIImage+Extensions.swift
//  FastLook
//
//  Created by YEHAN on 2021/5/7.
//

import UIKit

//MARK: 截图
extension UIImage {
    /// 对指定视图进行截图
    /// - Parameter view: 待截图的视图
    /// - Returns: 截图
    static func screenCapture(_ view: UIView, finished: ((UIImage) -> ())?) {
        ///开启图片类型的上下文（创建位视图并且让其成为当前的上下文）
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0)
        ///获取当前的上下文
        let context = UIGraphicsGetCurrentContext()!
        ///将view的内容放到上下文中进行渲染
        view.layer.render(in: context)
        ///获取截图后的图像
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        ///关闭图形上下文
        UIGraphicsEndImageContext()
        finished?(image)
    }
    
}

extension UIImage {
    /// 给图片添加水印
    /// - Parameters:
    ///   - backgroundImage: 背景图片
    ///   - logoImage: 水印图片
    ///   - logoContent: 水印文字
    ///   - save: 是否保存
    /// - Returns: 添加水印后的图片
    private func addWaterMask(backgroundImage: UIImage,
                              logoImage: UIImage?,
                              logoContent: String?,
                              save: Bool = true) -> UIImage {
        ///开启图片类型的上下文（创建位视图并且让其成为当前的上下文）
        UIGraphicsBeginImageContextWithOptions(backgroundImage.size, false, 0)
        ///画背景图像
        backgroundImage.draw(at: .zero)
        if let logoContent = logoContent as NSString?{
            logoContent.draw(at: CGPoint(x: 100, y: 100), withAttributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 50),NSAttributedString.Key.foregroundColor:UIColor.black])
        }
        if let logoImage = logoImage {
            logoImage.draw(at: CGPoint(x: backgroundImage.size.width * 0.6, y: backgroundImage.size.width * 0.7))
        }
        ///获取截图后的图像
        let image = UIGraphicsGetImageFromCurrentImageContext()
        ///关闭图形上下文
        UIGraphicsEndImageContext()
        ///是否保存到相册，默认保存
        if save == true {
            UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        }
        return image!
    }
    
    /// 根据颜色生成图片
    /// - Parameters:
    ///   - color: UIColor
    ///   - size: CGSize
    /// - Returns: UIImage
    static func imageWithColor(color: UIColor,
                                size: CGSize = .init(width: 1, height: 1)) -> UIImage? {
        if size.width <= 0 || size.height <= 0 {
            return nil
        }
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        // 开启图形上下文
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    /// 着色
    /// - Parameter color: 颜色
    func tint(color: UIColor) -> UIImage {
        let size = self.size
        
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()
        self.draw(at: CGPoint.zero, blendMode: CGBlendMode.normal, alpha: 1.0)
        
        context!.setFillColor(color.cgColor)
        context!.setBlendMode(CGBlendMode.sourceIn)
        context!.setAlpha(1.0)
        
        let rect = CGRect(
            x: CGPoint.zero.x,
            y: CGPoint.zero.y,
            width: self.size.width,
            height: self.size.height)
        UIGraphicsGetCurrentContext()!.fill(rect)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return tintedImage
    }
    
    static func base64(_ string: String) -> UIImage? {
        //base64转image
        if  let imageData = Data(base64Encoded: string){
            // 将Data转化成图片
            return UIImage(data: imageData)
        }
        return nil
    }
    
    /// 根据尺寸重新生成图片
    ///
    /// - Parameter size: 设置的大小
    /// - Returns: 新图
    func zip(newSize: CGSize) -> UIImage? {
        if self.size.height > newSize.height {
            let width = newSize.height / self.size.height * self.size.width
            let newImgSize = CGSize(width: width, height: newSize.height)
            UIGraphicsBeginImageContext(newImgSize)
            self.draw(in: CGRect(x: 0, y: 0, width: newImgSize.width, height: newImgSize.height))
            let theImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return theImage
        } else {
            let newImgSize = CGSize(width: newSize.width, height: newSize.height)
            UIGraphicsBeginImageContext(newImgSize)
            self.draw(in: CGRect(x: 0, y: 0, width: newImgSize.width, height: newImgSize.height))
            let theImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return theImage
        }
    }
    
    /// 图片旋转
    /// - Parameter degrees: 度数
    /// - Returns: image
    func imageRotated(on degrees: CGFloat) -> UIImage {
        // Following code can only rotate images on 90, 180, 270.. degrees.
        let degrees = round(degrees / 90) * 90
        let sameOrientationType = Int(degrees) % 180 == 0
        let radians = CGFloat.pi * degrees / CGFloat(180)
        let newSize = sameOrientationType ? size : CGSize(width: size.height, height: size.width)
        
        UIGraphicsBeginImageContext(newSize)
        defer {
            UIGraphicsEndImageContext()
        }
        
        guard let ctx = UIGraphicsGetCurrentContext(), let cgImage = cgImage else {
            return self
        }
        
        ctx.translateBy(x: newSize.width / 2, y: newSize.height / 2)
        ctx.rotate(by: radians)
        ctx.scaleBy(x: 1, y: -1)
        let origin = CGPoint(x: -(size.width / 2), y: -(size.height / 2))
        let rect = CGRect(origin: origin, size: size)
        ctx.draw(cgImage, in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image ?? self
    }
    
    // zip 不模糊
    func scaleToSize(size:CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size,false,0)
        self.draw(in: CGRect(x: 0,y: 0,width: size.width,height: size.height))
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    
    func scaled(to newSize: CGSize,size:CGSize) -> UIImage {
        //计算比例
        let aspectWidth  = newSize.width/size.width
        let aspectHeight = newSize.height/size.height
        let aspectRatio = max(aspectWidth, aspectHeight)
        
        //图片绘制区域
        var scaledImageRect = CGRect.zero
        scaledImageRect.size.width  = size.width * aspectRatio
        scaledImageRect.size.height = size.height * aspectRatio
        scaledImageRect.origin.x    = 0
        scaledImageRect.origin.y    = 0
        
        //绘制并获取最终图片
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)//图片不失真
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
    
    /**
     *从图片中按指定的位置大小截取图片的一部分
     * UIImage image 原始的图片
     * CGRect rect 要截取的区域
     */
    func imageFromImage(image:UIImage,rect:CGRect) -> UIImage {
        //将UIImage转换成CGImageRef
        let sourceImageRef = image.cgImage
        //按照给定的矩形区域进行剪裁
        let newImageRef = sourceImageRef?.cropping(to: rect)
        let newImage =  UIImage.init(cgImage: newImageRef!)
        return newImage
    }

    func fixOrientation(image:UIImage) -> UIImage {
        if image.imageOrientation == .up {
            return image
        }
        
        var transform = CGAffineTransform.identity
        
        switch image.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: image.size.width, y: image.size.height)
            transform = transform.rotated(by: .pi)
            break
            
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: image.size.width, y: 0)
            transform = transform.rotated(by: .pi / 2)
            break
            
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: image.size.height)
            transform = transform.rotated(by: -.pi / 2)
            break
            
        default:
            break
        }
        
        switch image.imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: image.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
            break
            
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: image.size.height, y: 0);
            transform = transform.scaledBy(x: -1, y: 1)
            break
            
        default:
            break
        }
        
        let ctx = CGContext(data: nil, width: Int(image.size.width), height: Int(image.size.height), bitsPerComponent: image.cgImage!.bitsPerComponent, bytesPerRow: 0, space: image.cgImage!.colorSpace!, bitmapInfo: image.cgImage!.bitmapInfo.rawValue)
        ctx?.concatenate(transform)
        
        switch image.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx?.draw(image.cgImage!, in: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(image.size.height), height: CGFloat(image.size.width)))
            break
            
        default:
            ctx?.draw(image.cgImage!, in: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(image.size.width), height: CGFloat(image.size.height)))
            break
        }
        
        let cgimg: CGImage = (ctx?.makeImage())!
        let img = UIImage(cgImage: cgimg)
        
        return img
    }
    
    func initWithImage(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0,y: 0,width: 1,height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
//    /// 裁剪正方形
//    func cropping() -> UIImage? {
//        let length: CGFloat
//        let x: CGFloat
//        let y: CGFloat
//        if size.width > size.height {
//            length = size.height * scale
//            x = (size.width - size.height) * scale / 2
//            y = 0
//        } else {
//            length = size.width * scale
//            x = 0
//            y = (size.height - size.width) * scale / 2
//        }
//        let croppingRect = CGRect(x: x, y: y, width: length, height: length)
//        // 截取部分图片并生成新图片
//        guard let sourceImageRef = self.cgImage else { return nil }
//        guard let newImageRef = sourceImageRef.cropping(to: croppingRect) else { return nil }
//        let newImage = UIImage(cgImage: newImageRef, scale: scale, orientation: .up)
//        return newImage
//    }
    
//    // 将图片裁剪成指定比例（多余部分自动删除）
//    /// - Parameter ratio: 宽高比
//    /// - Returns: 返回图片
//    func crop(ratio: CGFloat) -> UIImage {
//        //计算最终尺寸
//        var newSize:CGSize!
//        if size.width/size.height > ratio {
//            newSize = CGSize(width: size.height * ratio, height: size.height)
//        }else{
//            newSize = CGSize(width: size.width, height: size.width / ratio)
//        }
//
//        ////图片绘制区域
//        var rect = CGRect.zero
//        rect.size.width  = size.width
//        rect.size.height = size.height
//        rect.origin.x    = (newSize.width - size.width ) / 2.0
//        rect.origin.y    = (newSize.height - size.height ) / 2.0
//
//        //绘制并获取最终图片
//        UIGraphicsBeginImageContext(newSize)
//        draw(in: rect)
//        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//        return scaledImage!
//    }

    
//    /// 修正图片
//    /// - Parameter aImage: <#aImage description#>
//    /// - Returns: <#description#>
//    func fixOrientation() -> UIImage {
//        // No-op if the orientation is already correct
//        if self.imageOrientation == .up {//代表手机是竖屏图片正常
//            return self.crop(ratio: 1)
//        }
//        // We need to calculate the proper transformation to make the image upright.
//        // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
//        var transform: CGAffineTransform = CGAffineTransform.identity
//        switch self.imageOrientation {
//        case .down, .downMirrored:
//            transform = transform.translatedBy(x: self.size.width, y: self.size.height)
//            transform = transform.rotated(by: .pi)
//        case .left, .leftMirrored:
//            transform = transform.translatedBy(x: self.size.width, y: 0)
//            transform = transform.rotated(by: .pi/2)
//        case .right, .rightMirrored:
//            transform = transform.translatedBy(x: 0, y: self.size.height)
//            transform = transform.rotated(by: .pi/2)
//        default:
//            break
//        }
//
//        switch self.imageOrientation {
//        case .upMirrored, .downMirrored:
//            transform = transform.translatedBy(x: self.size.width, y: 0)
//            transform = transform.scaledBy(x: -1, y: 1)
//        case .leftMirrored, .rightMirrored:
//            transform = transform.translatedBy(x: self.size.height, y: 0)
//            transform = transform.scaledBy(x: -1, y: 1)
//        default:
//            break
//        }
//
//        // Now we draw the underlying CGImage into a new context, applying the transform
//        // calculated above.
//
//
//
//        let ctx: CGContext = CGContext(data: nil, width: Int(self.size.width), height: Int(self.size.height), bitsPerComponent: self.cgImage!.bitsPerComponent, bytesPerRow: 0, space: self.cgImage!.colorSpace!, bitmapInfo: self.cgImage!.bitmapInfo.rawValue)!
//        ctx.concatenate(transform)
//        switch self.imageOrientation {
//        case .left, .leftMirrored, .right, .rightMirrored:
//            // Grr...
//            ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: self.size.height, height: self.size.width))
//        default:
//            ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: self.size.height, height: self.size.width))
//        }
//
//        // And now we just create a new UIImage from the drawing context
//        let cgimg: CGImage = ctx.makeImage()!
//        let img: UIImage = UIImage(cgImage: cgimg)
//        return img.crop(ratio: 1)
//    }
}
