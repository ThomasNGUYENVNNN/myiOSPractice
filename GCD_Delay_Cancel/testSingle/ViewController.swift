//
//  ViewController.swift
//  testSingle
//
//  Created by SHUN on 2016/6/13.
//  Copyright © 2016年 SHUN. All rights reserved.
//

import UIKit




class ViewController: UIViewController {
    var labelFirstName: UILabel?
    var labelLastName: UILabel?
    
    @IBAction func touch(sender: AnyObject) {

    }
    
    @IBOutlet weak var sbutton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let task = delay(1) { print("拨打 110") }

        // 仔细想一想..
        // 还是取消为妙..
        cancel(task)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    typealias Task = (cancel : Bool) -> Void
    
    func delay(time:NSTimeInterval, task:()->()) ->  Task? {
        
        
        func dispatch_later(block:()->()) {
            dispatch_after(
                dispatch_time(
                    DISPATCH_TIME_NOW,
                    Int64(time * Double(NSEC_PER_SEC))),
                dispatch_get_main_queue(),
                block)
        }
        
        
        
        
        var closure: dispatch_block_t? = task
        var result: Task?
        
        
        
        
        let delayedClosure: Task = {
            cancel in
            if let internalClosure = closure {
                if (cancel == false) {
                    dispatch_async(dispatch_get_main_queue(), internalClosure);
                }
            }
            closure = nil
            result = nil
        }
        
        
        
        
        result = delayedClosure
        
        
        
        
        dispatch_later({
            if let delayedClosure = result {
                delayedClosure(cancel: false)
            }
        
        })
        
        
        
        return result;
    }
    
    
    
    func cancel(task:Task?) {
        task?(cancel: true)
    }
    
    
    
}



