//
//  SpeechRecognizerTypeEnum.swift
//  SpeechToTextDemo
//
//  Created by SHUN on 12/13/16.
//  Copyright © 2016 q2650108. All rights reserved.
//

import Foundation

@objc enum SpeechRecognizerTypeEnum : Int {
    case Authorized = 0
    case Denied = 1
    case Restricted = 2
    case NotDetermined = 3
    case UnsetAudioSessionProperties = 4
    case NoInputNode = 5
    case UnableToCreateObject = 6
    case AudioEngineCouldNotStart = 7
    
    
    
    /// App Listening
    case Listening = 30
    
    case StartSpeak = 31
    case Speaking = 32
    case EndSpeak = 33
    
    /// App Playback
    case EndPlayback = 40
}
