//
//  UTL.swift
//  SpeechToTextDemo
//
//  Created by SHUN on 12/12/16.
//  Copyright © 2016 q2650108. All rights reserved.
//

import UIKit
import Foundation

class UTL {
    
    /// 取得螢幕大小
    ///
    /// (get SCREEN SIZE)
    /// - Returns :     3.5     iphone4,4s;
    ///                 4       iphone5,5s;
    ///                 4.7     iphone6,6s;
    ///                 5.5     iphone6 plus,6s plus;
    /// - Author : SHUN
    /// - Date : 20160406
    static func getScreenSize() -> Double {
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHieght = UIScreen.main.bounds.size.height
        let screenMaxLength = max(screenWidth, screenHieght)
        //let screenMinLength = min(screenWidth, screenHieght)
        
        ///Get current device is iphone or ipad
        //var device : UIUserInterfaceIdiom = UIDevice.currentDevice().userInterfaceIdiom
        var deviceScreenSize : Double = 0
        
        if (screenMaxLength < 568.0){
            deviceScreenSize = 3.5
        }else if (screenMaxLength == 568.0){
            deviceScreenSize = 4
        }else if (screenMaxLength == 667){
            deviceScreenSize = 4.7
        }else if (screenMaxLength == 736){
            deviceScreenSize = 5.5
        }
        return deviceScreenSize
    }
}
