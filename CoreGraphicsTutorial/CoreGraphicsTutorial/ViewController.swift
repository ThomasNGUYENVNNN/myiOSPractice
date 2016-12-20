//
//  ViewController.swift
//  CoreGraphicsTutorial
//
//  Created by SHUN on 2016/7/6.
//  Copyright © 2016年 NKG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //Counter outlets
    @IBOutlet weak var counterView: CounterView!
    @IBOutlet weak var counterLabel: UILabel!
    
    
    @IBAction func btnPushButton(button: PushButtonView) {
        if button.isAddButton {
            counterView.counter+=1
        } else {
            if counterView.counter > 0 {
                counterView.counter-=1
            }
        }
        counterLabel.text = String(counterView.counter)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        counterLabel.text = String(counterView.counter)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

