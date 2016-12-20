//
//  MessageEntity.swift
//  SpeechToTextDemo
//
//  Created by SHUN on 12/12/16.
//  Copyright © 2016 q2650108. All rights reserved.
//
import UIKit
import Foundation

class MessageEntity {
    
    
    //==============================//
    // MARK:      Property
    //=============================//
    
    /// message is AI or not
    /// True is Ai , False is User
    var isAI : Bool = true
    
    /// Message
    var message : String = ""
    
    /// Time
    var time : String = ""
    
    /// Cell Singe Or Multi
    /// True is Singe , False is Multi
    var isSingleContent : Bool = true
    
    /// Cell Height
    var cellHeight : CGFloat = 0.0
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    
    init( isAI : Bool , message : String , time : String  ){
        self.isAI = isAI
        self.message = message
        self.time = time
    }
    
}
