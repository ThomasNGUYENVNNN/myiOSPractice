//
//  CounterView.swift
//  CoreGraphicsTutorial
//
//  Created by SHUN on 2016/7/7.
//  Copyright © 2016年 NKG. All rights reserved.
//

import UIKit

let NoOfGlasses = 8
let π:CGFloat = CGFloat(M_PI)

@IBDesignable class CounterView: UIView {
    
    @IBInspectable var counter: Int = 5 {
        didSet {
            if counter <=  NoOfGlasses {
                //the view needs to be refreshed
                setNeedsDisplay()
            }
        }
    }
    @IBInspectable var outlineColor: UIColor = UIColor.blueColor()
    @IBInspectable var counterColor: UIColor = UIColor.orangeColor()
    
    override func drawRect(rect: CGRect) {
        
        // 1       Define the center point of the view where you’ll rotate the arc around.
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        
        // 2       Calculate the radius based on the max dimension of the view.
        let radius: CGFloat = max(bounds.width, bounds.height)
        
        // 3    Define the thickness of the arc.
        let arcWidth: CGFloat = 76
        
        // 4   Define the start and end angles for the arc.
        let startAngle: CGFloat = 3 * π / 4
        let endAngle: CGFloat = π / 4
        
        // 5         Create a path based on the center point, radius, and angles you just defined.
        let path = UIBezierPath(arcCenter: center,
                                radius: radius/2 - arcWidth/2,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: true)
        
        // 6        Set the line width and color before finally stroking the path.
        path.lineWidth = arcWidth
        counterColor.setStroke()
        path.stroke()
        
        
        
        //Draw the outline
        
        //1 - first calculate the difference between the two angles
        //ensuring it is positive
        let angleDifference: CGFloat = 2 * π - startAngle + endAngle
        
        //then calculate the arc for each single glass
        let arcLengthPerGlass = angleDifference / CGFloat(NoOfGlasses)
        
        //then multiply out by the actual glasses drunk
        let outlineEndAngle = arcLengthPerGlass * CGFloat(counter) + startAngle
        
        //2 - draw the outer arc
        let outlinePath = UIBezierPath(arcCenter: center,
                                       radius: bounds.width/2 - 2.5,
                                       startAngle: startAngle,
                                       endAngle: outlineEndAngle,
                                       clockwise: true)
        //3 - draw the inner arc
        outlinePath.addArcWithCenter(center,
                                     radius: bounds.width/2 - arcWidth + 2.5,
                                     startAngle: outlineEndAngle,
                                     endAngle: startAngle,
                                     clockwise: false)
        
        
        //4 - close the path
        outlinePath.closePath()
        
        outlineColor.setStroke()
        outlinePath.lineWidth = 5.0
        outlinePath.stroke()
        
    }
}