//
//  SpeechRecognizerDelegate.swift
//  SpeechToTextDemo
//
//  Created by SHUN on 12/13/16.
//  Copyright © 2016 q2650108. All rights reserved.
//

import Foundation

@objc protocol SpeechRecognizerDelegate : class {
    @objc optional func speechRecognizer( type : SpeechRecognizerTypeEnum , message : String? )
}
