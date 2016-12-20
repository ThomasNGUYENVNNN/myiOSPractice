//
//  MainVC.swift
//  SpeechToTextDemo
//
//  Created by SHUN on 12/12/16.
//  Copyright © 2016 q2650108. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    
    //==============================//
    // MARK:     Public Property
    //=============================//
    
    
    
    //==============================//
    // MARK:     Layout Property
    //=============================//
    @IBOutlet weak var buttonEnter: UIButton!
    
    @IBOutlet weak var viewAnimationTop: UIView!
    
    @IBOutlet weak var viewAnimationBottom: UIView!
    
    /// Animation Container
    @IBOutlet weak var viewAnimationContainer: UIView!
    
    /// ICon
    @IBOutlet weak var imageViewICon: UIImageView!
    
    
    //==============================//
    // MARK:     Action
    //=============================//
    
    @IBAction func buttonEnterTouchUpInside(_ sender: Any) {
        viewAnimationContainer.isHidden = false
        buttonEnter.isHidden = true
        
        /// Icon  360 degrees infinitely in Swift?
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat.pi * 2
        rotateAnimation.duration = 0.75
        rotateAnimation.delegate = self
        
        self.imageViewICon.layer.add(rotateAnimation, forKey: nil)
        
    }
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initValue()
        
        self.imageViewICon.layer.cornerRadius = self.imageViewICon.frame.width / 2
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit{
        print("\( type(of: self) ) deinit")
        
    }
    
    //==============================//
    // MARK:      Private Func
    //=============================//
    
    private func initValue(){
        
        viewAnimationContainer.isHidden = true
        buttonEnter.isHidden = false
    }
    
    //==============================//
    // MARK:      Public Func
    //=============================//
    
}

extension MainVC : CAAnimationDelegate{
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        
        UIView.animate(withDuration: 1 , animations: {
            self.imageViewICon.frame.origin.y -= self.view.frame.height
            self.viewAnimationTop.frame.origin.y -= self.view.frame.height
            self.viewAnimationBottom.frame.origin.y += self.view.frame.height
            
        }, completion: ({
            
            ( finished : Bool ) in
            
            self.viewAnimationContainer.isHidden = true
            
            self.performSegue(withIdentifier: "showEnter", sender: nil)
            
            self.imageViewICon.frame.origin.y += self.view.frame.height
            self.viewAnimationTop.frame.origin.y += self.view.frame.height
            self.viewAnimationBottom.frame.origin.y -= self.view.frame.height
            
        }))
        
    }
}
