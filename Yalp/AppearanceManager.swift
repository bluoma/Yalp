//
//  AppearanceManager.swift
//  Yalp
//
//  Created by Bill on 9/12/16.
//  Copyright © 2016 BillLuoma. All rights reserved.
//  Based on https://www.raywenderlich.com/108766/uiappearance-tutorial

import UIKit



class AppearanceManager
{
    
    static func applyBlackTranslucentTheme(window: UIWindow?) {
        
        UINavigationBar.appearance().barStyle = .black
        UINavigationBar.appearance().isTranslucent = true
        UITabBar.appearance().barStyle = .black
        UITabBar.appearance().isTranslucent = true
        //UINavigationBar.appearance().backIndicatorImage = UIImage(named: "backArrow")
        //UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "backArrowMask")
        
        window?.tintColor = UIColor(red: 40.0/255.0, green:180.0/255.0, blue: 180.0/255.0, alpha: 1.0)

        //cyan: UIColor { get } // 0.0, 1.0, 1.0 RGB
        
    }
    
    static func applyDefaultOpaqueRedTheme(window: UIWindow?) {
        
        UINavigationBar.appearance().barStyle = .default
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = UIColor(red: 204/255, green: 47/255, blue: 40/255, alpha: 1.0) // a lovely red
        
        UINavigationBar.appearance().tintColor = UIColor.white // for titles, buttons, etc.
        
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
            
        
        //UITabBar.appearance().barStyle = .default
        //UITabBar.appearance().isTranslucent = true
        
        //UINavigationBar.appearance().backIndicatorImage = UIImage(named: "backArrow")
        //UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "backArrowMask")
        
        //window?.tintColor = UIColor(red: 40.0/255.0, green:180.0/255.0, blue: 180.0/255.0, alpha: 1.0)
        
        window?.tintColor = UIColor(white: 1.0, alpha: 1.0)
        
        //cyan: UIColor { get } // 0.0, 1.0, 1.0 RGB
        
    }

    
}
