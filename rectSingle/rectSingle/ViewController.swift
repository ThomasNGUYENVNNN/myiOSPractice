//
//  ViewController.swift
//  rectSingle
//
//  Created by SHUN on 2016/6/13.
//  Copyright © 2016年 SHUN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var greenVIew: UIView!
    
    @IBOutlet weak var redView: UIView!
    
    @IBOutlet weak var blueView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        print("greenVIew: \(greenVIew)")
        print("redView: \(redView.frame)")
        print("redView: \(redView.bounds)")
        print("blueView: \(blueView.frame)")
               print("blueView: \(blueView.bounds)")
        
        print("toView: self.view :  \( redView.convertRect(redView.frame, toView: self.view))")
        print("fromView: greend :  \( self.view.convertRect(redView.frame, fromView: greenVIew))")
        
        
        print("toView: self :  \( redView.convertRect(CGRectMake(50, 50, 100, 100), toView: self.view))")
        print("toView: greenVIew :  \( redView.convertRect(CGRectMake(50, 50, 100, 100), toView: greenVIew))")
        
        
        print("blueView.frame, :  \( redView.convertRect(redView.bounds, toView: blueView))")
        
        let v1 = UIView(frame: redView.convertRect(redView.bounds, toView: blueView))
        v1.backgroundColor = UIColor.blackColor()
        blueView.addSubview(v1)
        
        
        print("(blueView.bounds :  \( redView.convertRect(redView.frame, toView: blueView))")
        
        let v2 = UIView(frame: redView.convertRect(redView.bounds, toView: blueView))
        v2.backgroundColor = UIColor.brownColor()
        self.view.insertSubview(v2, aboveSubview: blueView)
    }
    
    
}

