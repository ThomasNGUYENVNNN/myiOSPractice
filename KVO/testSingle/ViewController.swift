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
    var person:Person?
    
    @IBAction func touch(sender: AnyObject) {
        
       self.person?.firstName = "mother"
        self.person?.lastName  = "FK"
        

    }
    
    @IBOutlet weak var sbutton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        self.labelFirstName = UILabel(frame: CGRectMake(10, 50, 100, 100))
        self.labelLastName = UILabel(frame: CGRectMake(10, 200, 100, 100))
        
        self.labelFirstName?.textColor  = UIColor.blackColor()
        self.labelLastName?.textColor  = UIColor.blackColor()
        
        self.view.addSubview(self.labelFirstName!)
        self.view.addSubview(self.labelLastName!)
        
        self.person = Person(firstName: "peter", lastName: "cook")
        
        self.person?.addObserver(self, forKeyPath: "firstName", options: [NSKeyValueObservingOptions.New,NSKeyValueObservingOptions.Initial,NSKeyValueObservingOptions.Prior], context: nil)
        self.person?.addObserver(self, forKeyPath: "lastName", options: [NSKeyValueObservingOptions.New,NSKeyValueObservingOptions.Initial,NSKeyValueObservingOptions.Prior], context: nil)
        
    }
    
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if keyPath == "firstName" {
            
            if let firstName = change?[NSKeyValueChangeNewKey] as? String {
                
                self.labelFirstName?.text = firstName
                
            }
            
            if let key = change?[NSKeyValueChangeNotificationIsPriorKey] {
                
                print("old \(key)")
            
                
            }else {
                
                print("new")            
                
            }
            
            
            
        } else if keyPath == "lastName" {
            
            if let lastName = change?[NSKeyValueChangeNewKey] as? String {
                
                self.labelLastName?.text = lastName
                
            }
            
        }
        
    }
    
}



