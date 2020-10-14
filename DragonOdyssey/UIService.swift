//
//  UIService.swift
//  HarmLess
//
//  Created by Jared on 9/21/20.
//  Copyright © 2020 Wired Betterment. All rights reserved.
//

import UIKit

class UIService: NSObject {
    
    static let statusBarHeight: CGFloat = 20
    static let statusBarIphoneXHeight: CGFloat = 44
    static let navBarHeight: CGFloat = 44
    static let tabBarHeight: CGFloat = 49
    static let bottomBarIphoneXHeight: CGFloat = 34

    // MARK: - Device detection
    
    enum DeviceScreenSizeType { case _4In, _4_7In, _5_5In, _5_8In, _6_1In, _6_5In }
    
    static var deviceScreenSize: DeviceScreenSizeType { get {
        
        switch screenSizeInPixels.height
        {
        case 2688:
            return ._6_5In
        case 2436:
            return ._5_8In
        case 1792:
            return ._6_1In
        case 2208:
            return ._5_5In
        case 1334:
            return ._4_7In
        case 1136:
            return ._4In
        default:
            return ._4_7In
        }
        }}
    
    // MARK: - Screen resolution

    class func systemHeights() -> (statusBarHeight: Int, tabBarHeight: Int, navBarHeight: Int) {
        return (statusBarHeight: 20, tabBarHeight: 49, navBarHeight: 44)
    }
    
    class func availableHeightAfterStatusBarTabBarNavBar () -> Int {
        let screenHeight: Int = Int (screenSize().height)
        return screenHeight - (self.systemHeights().statusBarHeight + self.systemHeights().tabBarHeight + self.systemHeights().navBarHeight)
    }
    
    class func availableHeightAfterTabBarNavBar () -> Int {
        let screenHeight: Int = Int (screenSize().height)
        return screenHeight - (self.systemHeights().tabBarHeight + self.systemHeights().navBarHeight)
    }
    
    @objc static var standardViewAvailableHeight: CGFloat { get {
        
        let screenHeight = screenSize().height
        
        var totalBarsHeight:CGFloat = 0
        
        if deviceIsXSeries()
        {
            totalBarsHeight = statusBarIphoneXHeight + navBarHeight + tabBarHeight + bottomBarIphoneXHeight
        }
        else
        {
            totalBarsHeight = navBarHeight + tabBarHeight
        }
        
        return screenHeight - totalBarsHeight
        }}
    
    class func screenSize() -> CGSize {
        let screenFrame: CGRect = UIScreen.main.bounds
        return CGSize(width: screenFrame.size.width, height: screenFrame.size.height)
    }
    
    static var screenSizeInPixels: CGSize { get {
        let screenBounds = UIScreen.main.bounds
        let screenScale = UIScreen.main.scale
        let screenSize = CGSize(width: screenBounds.size.width * screenScale, height: screenBounds.size.height * screenScale)
        
        return screenSize
        }}
    
    class func rectToFitScreen() -> CGRect {
        return CGRect(x: 0, y: 0, width: self.screenSize().width, height: self.screenSize().height)
    }
    
    @objc class func deviceIsXSeries() -> Bool {
        if UIDevice().userInterfaceIdiom == .phone {
            if deviceScreenSize == ._6_5In
                || deviceScreenSize == ._6_1In
                || deviceScreenSize == ._5_8In
            { return true }
        }
        return false
    }
    
    @objc class func screenDimensionsOfIphoneXMinusStatusBarAndBottomBar() -> CGSize {
        let screenDimensions = self.screenSize()
        let height = screenDimensions.height - statusBarIphoneXHeight - bottomBarIphoneXHeight
        
        return CGSize(width: screenDimensions.width, height: height)
    }
    
    // MARK: - Circles
    
    static func parametricPointFor(baseVRect: CGRect, angle: CGFloat, plottedVRect: CGRect) -> CGPoint {
        let adjustedAngle = angle - 90
        let radius: CGFloat = baseVRect.size.width / 2
        let origin: CGFloat = radius
        let plottedVCenter: CGFloat = plottedVRect.size.width / 2
        let xCord: CGFloat = (radius * cos((adjustedAngle * .pi) / 180.0)) + origin - plottedVCenter
        let yCord: CGFloat = (radius * sin((adjustedAngle * .pi) / 180.0)) + origin - plottedVCenter
        
        return CGPoint(x: xCord, y: yCord)
    }
    
    // MARK: - ViewControllers
    
    class func topMostViewController() -> UIViewController? {
        if var topVC = UIApplication.shared.keyWindow?.rootViewController
        {
            while let presentedViewController = topVC.presentedViewController
            {
                topVC = presentedViewController
            }
            return topVC
        }
        return nil
    }
    
//    static var topMostVCAsPresentedVCDelegate: PresentedVCDelegate? {
//        guard let topVC = topMostViewController() else { return nil }
//
//        var delegate: PresentedVCDelegate?
//
//        switch topVC {
////        case is AppPVCContainingVC: delegate = UIManager.shared.mainVC
////        case is DrinkVC: delegate = topVC as! DrinkVC
////        case is DayVC: delegate = topVC as! DayVC
//        default: break
//        }
//        return delegate
//    }
}
