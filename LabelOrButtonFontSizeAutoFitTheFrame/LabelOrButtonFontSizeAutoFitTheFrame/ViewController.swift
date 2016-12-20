//
//  ViewController.swift
//  LabelOrButtonFontSizeAutoFitTheFrame
//
//  Created by SHUN on 10/6/16.
//  Copyright © 2016 q2650108. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label_1: UILabel!
    
    @IBOutlet weak var label_2: UILabel!
    
    @IBOutlet weak var label_3: UILabel!
    
    
    
    @IBOutlet weak var btn_1: UIButton!
    
    @IBOutlet weak var btn_2: UIButton!
    
    @IBOutlet weak var btn_3: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        /// 有時候Button Frame 過大 , 會變成省略
        /// lineBreakMode 選 ByClipping can Fix it
        btn_1.titleLabel!.adjustFontSizeToFitRect(btn_1.frame)
        label_1.adjustFontSizeToFitRect(label_1.frame)
        
        
        btn_2.titleLabel!.adjustFontSizeToFitRect(btn_2.frame)
        label_2.adjustFontSizeToFitRect(label_2.frame)
        
        
        btn_3.titleLabel!.adjustFontSizeToFitRect(btn_3.frame)
        label_3.adjustFontSizeToFitRect(label_3.frame)
        
        
    }
    
    /// 以下兩種方法,無法適用全部情況
    /// Not Working
    func buttonFitSize(but:UIButton){
        but.titleLabel!.font = UIFont.systemFontOfSize(50)
        but.titleLabel!.numberOfLines = 1
        but.titleLabel!.minimumScaleFactor =  0.01
        but.titleLabel!.adjustsFontSizeToFitWidth = true
        
        but.titleLabel!.lineBreakMode = .ByClipping
        
    }
    
    func labelFitSize(lab:UILabel){
        lab.font = UIFont.systemFontOfSize(50)
        lab.numberOfLines = 1
        lab.minimumScaleFactor =  0.01
        lab.adjustsFontSizeToFitWidth = true
        
        
    }
    
}

