//
//  DrawPie.swift
//  DrawPie
//
//  Created by SHUN on 2016/7/7.
//  Copyright © 2016年 NKG. All rights reserved.
//

import UIKit

class DrawPie: UIView {
    
    var fractions :[Double] = [0.5, 0.7, 0.3, 0.1, 1.0 , 0.6, 0.2, 0.9]
    
    override func drawRect(rect: CGRect) {
        let pi = M_PI
        let largestRadius = bounds.width/2
        

        
        
        let piePath = UIBezierPath()
        for (index, afloat) in fractions.enumerate()
        {
            let startAngle = Double(index) / afloat * 2 * pi
            let endAngle = Double(index+1) / afloat * 2 * pi
            let thisRadius = largestRadius
            let center = CGPointMake( bounds.width/2, bounds.height/2)
            piePath.moveToPoint(center)
            
            piePath.addArcWithCenter(center,
                                     radius: thisRadius,
                                     startAngle: CGFloat(startAngle),
                                     endAngle: CGFloat(endAngle),
                                     clockwise: true)
            piePath.addLineToPoint(center)
            piePath.closePath()
            
            
            UIColor.blackColor().setStroke()
            piePath.stroke()
        }
    }
    
    
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    
}
