//: Playground - noun: a place where people can play

import UIKit
import Foundation

var str = "Hello, playground"



//  String 轉為 NsString
let nsString : NSString = NSString(string: "some String has dynamic length")

// set the text color , 預設黑
let fieldColor: UIColor = UIColor.blackColor()

// set the 字型和大小 , 目前字型使用系統預設 system Font
let textSize:CGFloat = 15
let fieldFont = UIFont.systemFontOfSize(textSize)

// set the line spacing to 0 行距
let paraStyle = NSMutableParagraphStyle()
paraStyle.lineSpacing = 0.0
paraStyle.lineBreakMode = .ByWordWrapping

// set the Obliqueness 傾斜
let skew = 0.0

let attributes: NSDictionary = [
    NSForegroundColorAttributeName: fieldColor,
    NSParagraphStyleAttributeName: paraStyle,
    NSObliquenessAttributeName: skew,
    NSFontAttributeName: fieldFont
]

/// 寬度固定
let textWidth :CGFloat = 200
/// 寬度固定計算高度 
let size = nsString.boundingRectWithSize(CGSize(width: textWidth, height: CGFloat.max),options: NSStringDrawingOptions.UsesLineFragmentOrigin,
                                         attributes: (attributes as! [String : AnyObject]) ,
                                         context: nil).size
