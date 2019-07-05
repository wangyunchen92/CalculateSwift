//
//  Tools.swift
//  Browser
//
//  Created by 王云晨 on 2019/5/17.
//  Copyright © 2019 Sj03. All rights reserved.
//

import Foundation
import UIKit
// MARK: ===================================变量宏定义=========================================

// MARK: 系统相关
/// Info
public let kAppBundleInfoVersion = Bundle.main.infoDictionary ?? Dictionary()
/// plist:  AppStore 使用VersionCode 1.0.1
public let kAppBundleVersion = (kAppBundleInfoVersion["CFBundleShortVersionString" as String] as? String ) ?? ""
/// plist: 例如 1
public let kAppBundleBuild = (kAppBundleInfoVersion["CFBundleVersion"] as? String ) ?? ""
public let kAppDisplayName = (kAppBundleInfoVersion["CFBundleDisplayName"] as? String ) ?? ""

// MARK: 系统相关
public let kiOSBase = 8.0
public let kOSGreaterOrEqualToiOS8 = ( (Double(UIDevice.current.systemVersion) ?? kiOSBase) > 8.0 ) ? true : false;
public let kOSGreaterOrEqualToiOS9 = ((Double(UIDevice.current.systemVersion) ?? kiOSBase) >= 9.0 ) ? true : false;
public let kOSGreaterOrEqualToiOS10 = ((Double(UIDevice.current.systemVersion) ?? kiOSBase) >= 10.0 ) ? true : false;
public let kOSGreaterOrEqualToiOS11 = ((Double(UIDevice.current.systemVersion) ?? kiOSBase) >= 11.0 ) ? true : false;

func isiPhoneX() ->Bool {
    let screenHeight = UIScreen.main.nativeBounds.size.height;
    if screenHeight == 2436 || screenHeight == 1792 || screenHeight == 2688 || screenHeight == 1624 {
        return true
    }
    return false
}

func DefaultColor() -> UIColor  {
    return RGBCOLOR(r: 53, 151, 252)
}

public let DefaultNavgationHeight = (isiPhoneX() ? 88 : 64)


//设备宽高、机型
public let kScreenHeight = UIScreen.main.bounds.size.height
public let kScreenWidth = UIScreen.main.bounds.size.width
public let kStatusBarheight = UIApplication.shared.statusBarFrame.size.height
public let kNavBarHeight_StatusHeight: ((UIViewController)-> CGFloat) = {(vc : UIViewController ) -> CGFloat in
    weak var weakVC = vc;
    var navHeight = weakVC?.navigationController?.navigationBar.bounds.size.height ?? 0.0
    return (navHeight + kStatusBarheight)
    }

func RGBCOLOR(r:CGFloat,_ g:CGFloat,_ b:CGFloat) -> UIColor
{
    return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: 1.0)
}
func RGBACOLOR(r:CGFloat,_ g:CGFloat,_ b:CGFloat,_ a:CGFloat) -> UIColor
{
    return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: a)
}

func GetViewNowImage(view:UIView) -> (UIImage){
    let screenRect = UIScreen.main.bounds
    UIGraphicsBeginImageContext(screenRect.size)
    let ctx:CGContext = UIGraphicsGetCurrentContext()!
    view.layer.render(in: ctx)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext();
    
    return image!
}

let KAppdelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
