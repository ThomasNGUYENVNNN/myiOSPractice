//
//  UIViewUnderlineMenu.swift
//  SpeechToTextDemo
//
//  Created by SHUN on 12/13/16.
//  Copyright © 2016 q2650108. All rights reserved.
//

import UIKit
import Foundation


class UIViewUnderlineMenu : UIView {
    
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    weak var delegate : ViewUnderlineMenuDelegate?
    
    /// Menu item list
    private var menuItemList : [String] = [ "中文"  , "English" , "日本語" ]
    
    private var currentIndex  : Int = 0
    
    private var menuItemBackgroundColor : UIColor = UIColor.white
    
    private var underLineColor : UIColor = UIColor.black
    
    /// value = ( 0 , 1 )
    private var underLineWidthRatio : CGFloat = 0.3
    
    private var textNormalColor : UIColor = UIColor.lightGray
    
    private var textSelectedColor : UIColor = UIColor.black
    
    //==============================//
    // MARK:     Public Property
    //=============================//
    
    @IBInspectable
    var defaultSelectedItemIndex : Int {
        get {
            return currentIndex
        }
        set {
            currentIndex = newValue
        }
    }
    
    @IBInspectable
    var itemBackgroundColor : UIColor {
        get {
            return menuItemBackgroundColor
        }
        set {
            menuItemBackgroundColor = newValue
        }
    }
    
    @IBInspectable
    var lineColor : UIColor {
        get {
            return underLineColor
        }
        set {
            underLineColor = newValue
        }
    }
    
    @IBInspectable
    var lineWidth : CGFloat {
        get {
            return underLineWidthRatio
        }
        set {
            underLineWidthRatio = newValue
        }
    }
    
    @IBInspectable
    var normalTextColor : UIColor {
        get {
            return textNormalColor
        }
        set {
            textNormalColor = newValue
        }
    }
    
    
    @IBInspectable
    var selectedTextColor : UIColor {
        get {
            return textSelectedColor
        }
        set {
            textSelectedColor = newValue
        }
    }
    
    //==============================//
    // MARK:     Layout Property
    //=============================//
    
    /// view Under Line
    private var viewUnderLine : UIView = UIView( frame: CGRect.zero )
    
    /// view Menu Item List
    private var viewMenuItemList : [UILabel] = [UILabel]()
    
    
    //==============================//
    // MARK:     Action
    //=============================//
    
    func handleItemTap(_ sender: UITapGestureRecognizer) {
        guard let selectedIndex = sender.view?.tag else{
            return
        }
        
        self.currentIndex = selectedIndex
        toggleMenu( )
    }
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    
    override func draw(_ rect: CGRect) {
        initValue()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    deinit{
        print("\( type(of: self) ) deinit")
    }
    
    //==============================//
    // MARK:      Private Func
    //=============================//
    
    private func initValue(){
        /// init Menu Per Item
        
        
        /// Per Item Width , Height
        let perItemWidth = self.frame.width / CGFloat(menuItemList.count)
        let perItemHeight = self.frame.height * ( 1 - underLineWidthRatio )
        
        var totalX : CGFloat = 0.0
        for index in 0 ..< menuItemList.count {
            
            let viewItemContainer = UIView(frame:  CGRect(x: totalX, y: 0, width: perItemWidth, height: perItemHeight) )
            /// Set Background Color
            viewItemContainer.backgroundColor = self.menuItemBackgroundColor
            /// Set Tag
            viewItemContainer.tag = index
            /// Enabled Tap
            viewItemContainer.isUserInteractionEnabled = true
            /// Set Tap Gesture Recognizer
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleItemTap))
            viewItemContainer.addGestureRecognizer(tap)
            
            
            /// Set item Label
            let labelItem = UILabel()
            /// Set Frame
            labelItem.bounds = CGRect(x: 0, y: 0, width:  perItemWidth, height: perItemHeight)
            labelItem.center = CGPoint(x: viewItemContainer.frame.width / 2, y: viewItemContainer.frame.height / 2)
            
            /// Set Background Color
            labelItem.backgroundColor = self.menuItemBackgroundColor
            /// Set Text
            /// or use the localization string
            labelItem.text = menuItemList[index]
            
            /// Set Text Color
            labelItem.textColor = currentIndex == index ? textSelectedColor :textNormalColor
            /// Set Text Align
            labelItem.textAlignment = .center
            
            /// Set Text Font Size
            /// Get screen Size
            let screenSize = UTL.getScreenSize()
            var size : CGFloat  = 0.0
            
            if screenSize == 4 {
                size = 14
            }else if screenSize == 4.7 {
                size = 16
            }else if screenSize == 5.5 {
                size = 18
            }
            
            labelItem.font = UIFont.systemFont(ofSize: size)
            
            /// save in list
            viewMenuItemList.append(labelItem)
            /// add to self view
            viewItemContainer.addSubview(labelItem)
            self.addSubview(viewItemContainer)
            
            totalX += perItemWidth
        }
        
        /// init view Under Line
        
        let lineX = CGFloat(currentIndex) * perItemWidth
        let lineHeight = self.frame.height - perItemHeight
        /// Set Frame
        viewUnderLine = UIView(frame:  CGRect(x:  lineX , y: perItemHeight, width: perItemWidth, height: lineHeight) )
        /// Set background Color
        viewUnderLine.backgroundColor = underLineColor
        
        self.addSubview(viewUnderLine)
    }
    
    
    /// Switch the Menu
    private func toggleMenu( ){
        
        let perItemWidth = self.frame.width / CGFloat(menuItemList.count)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5 , initialSpringVelocity: 0.5 , options: [] , animations: {
            /// Under Line Animate
            self.viewUnderLine.frame.origin.x = CGFloat(self.currentIndex) * perItemWidth
            for ( index , item ) in self.viewMenuItemList.enumerated() {
                item.textColor = self.currentIndex == index ? self.textSelectedColor : self.textNormalColor
            }
            
        } , completion : nil )
        
        /// Delegate  - Return
        self.delegate?.viewUnderlineMenu(selectedIndex: self.currentIndex , selectedValue: self.menuItemList[self.currentIndex])
    }
    
    //==============================//
    // MARK:      Public Func
    //=============================//
    
    func getSelectedItem(){
        /// Delegate  - Return
        self.delegate?.viewUnderlineMenu(selectedIndex: self.currentIndex , selectedValue: self.menuItemList[self.currentIndex])
    }
    
    func getSelctedString(index : Int) -> String {
        return self.menuItemList[index]
    }
}
