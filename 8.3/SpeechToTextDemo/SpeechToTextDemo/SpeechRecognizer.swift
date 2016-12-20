//
//  SpeechRecognizer.swift
//  SpeechToTextDemo
//
//  Created by SHUN on 12/13/16.
//  Copyright © 2016 q2650108. All rights reserved.
//


import UIKit
import Speech
import Foundation

class SpeechRecognizer : NSObject{
    
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    weak var delagate : SpeechRecognizerDelegate?
    
    private static var mInstance : SpeechRecognizer?
    
    private var sFSpeechRecognizer : SFSpeechRecognizer?
    
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    
    private var recognitionTask: SFSpeechRecognitionTask?
    
    private var audioEngine : AVAudioEngine?
    
    private var mostRecentlyProcessedSegmentDuration: TimeInterval = 0
    
    //==============================//
    // MARK:     Public Property
    //=============================//
    
    
    
    //==============================//
    // MARK:     Layout Property
    //=============================//
    
    //==============================//
    // MARK:     Action
    //=============================//
    
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    
    static func sharedInstance( delegate : SpeechRecognizerDelegate ) -> SpeechRecognizer {
        
        SpeechRecognizer.sharedInstance( ).delagate = delegate
        
        return SpeechRecognizer.sharedInstance( )
    }
    
    
    static func sharedInstance( ) -> SpeechRecognizer {
        if mInstance == nil {
            mInstance = SpeechRecognizer()
            
        }
        
        return mInstance!
    }
    
    deinit{
        print("\( type(of: self) ) deinit")
        
    }
    
    //==============================//
    // MARK:      Private Func
    //=============================//
    
    private func initValue(){
        
        
    }
    
    //==============================//
    // MARK:      Public Func
    //=============================//
    
    /// get Authorization
    func getAuthorization(){
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            
            switch authStatus {
            case .authorized:
                SpeechRecognizer.sharedInstance( ).delagate?.speechRecognizer?(type: .Authorized , message: nil)
            case .denied:
                SpeechRecognizer.sharedInstance( ).delagate?.speechRecognizer?(type: .Denied , message: "User denied access to speech recognition")
            case .restricted:
                SpeechRecognizer.sharedInstance( ).delagate?.speechRecognizer?(type: .Restricted , message: "Speech recognition restricted on this device")
            case .notDetermined:
                SpeechRecognizer.sharedInstance( ).delagate?.speechRecognizer?(type: .NotDetermined , message: "Speech recognition not yet authorized")
            }
            
        }
    }
    
    
    func isAudioRunning() -> Bool{
        guard let engine = SpeechRecognizer.sharedInstance( ).audioEngine else {
            return false
        }
        
        if engine.isRunning {
            return true
        }
        return false
    }
    
    func StopRecording(){
        guard let engine = SpeechRecognizer.sharedInstance( ).audioEngine , let inputNode = engine.inputNode else {
            return
        }
        
        engine.stop()
        
        
        inputNode.removeTap(onBus: 0)
        
        SpeechRecognizer.sharedInstance( ).audioEngine = nil
        
        SpeechRecognizer.sharedInstance( ).recognitionRequest?.endAudio()
        SpeechRecognizer.sharedInstance( ).recognitionRequest = nil
        
        SpeechRecognizer.sharedInstance( ).recognitionTask = nil
        
    }
    
    func setLanguage( local : LocalEnum ){
        SpeechRecognizer.sharedInstance( ).sFSpeechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: local.rawValue ))!
        SpeechRecognizer.sharedInstance( ).sFSpeechRecognizer?.delegate = self
    }
    
    /// Set Audio Mode
    func setAudioSessionCategory( category: String ) -> Bool {
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(category)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            return false
        }
        return true
    }
    
    func startPlayBack( msg : String , language : String ){
        
        if setAudioSessionCategory(category: AVAudioSessionCategoryPlayback) {
            
            let speechUtterance = AVSpeechUtterance(string: msg)
            
            speechUtterance.voice = AVSpeechSynthesisVoice(language: language)
            
            speechUtterance.rate = 0.5
            speechUtterance.pitchMultiplier = 1
            speechUtterance.volume = 0.75
            
            let synthesizer = AVSpeechSynthesizer()
            synthesizer.speak(speechUtterance)
            synthesizer.delegate = self
        }
    }
    
    
    func startRecording() {
        
        if SpeechRecognizer.sharedInstance( ).recognitionTask != nil {
            SpeechRecognizer.sharedInstance( ).recognitionTask?.cancel()
            SpeechRecognizer.sharedInstance( ).recognitionTask = nil
        }
        
        if SpeechRecognizer.sharedInstance( ).audioEngine == nil {
            SpeechRecognizer.sharedInstance( ).audioEngine =  AVAudioEngine()
        }
        
        /// Ser Record Mode
        if !setAudioSessionCategory(category: AVAudioSessionCategoryRecord){
            SpeechRecognizer.sharedInstance( ).delagate?.speechRecognizer?(type: .UnsetAudioSessionProperties , message: "audioSession properties weren't set because of an error.")
            return
        }
        
        SpeechRecognizer.sharedInstance( ).mostRecentlyProcessedSegmentDuration = 0
        
        SpeechRecognizer.sharedInstance( ).recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let engine = SpeechRecognizer.sharedInstance( ).audioEngine , let inputNode = engine.inputNode else {
            SpeechRecognizer.sharedInstance( ).delagate?.speechRecognizer?(type: .NoInputNode , message: "Audio engine has no input node")
            return
        }
        
        guard let recognitionRequest = SpeechRecognizer.sharedInstance( ).recognitionRequest else {
            SpeechRecognizer.sharedInstance( ).delagate?.speechRecognizer?(type: .UnableToCreateObject , message: "Unable to create an SFSpeechAudioBufferRecognitionRequest object")
            return
        }
        
        SpeechRecognizer.sharedInstance( ).recognitionRequest?.shouldReportPartialResults = true
        
        
        SpeechRecognizer.sharedInstance( ).recognitionTask = SpeechRecognizer.sharedInstance( ).sFSpeechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: {
            
            (result, error) in
            
            SpeechRecognizer.sharedInstance( ).delagate?.speechRecognizer?(type: .StartSpeak , message: nil)
            
            var isFinal = false
            
            var speechingStr = ""
            
            if let _result = result {
                speechingStr = _result.bestTranscription.formattedString
                isFinal = _result.isFinal
                
                if let lastSegment = _result.bestTranscription.segments.last {
                    
                    
                    if lastSegment.duration > SpeechRecognizer.sharedInstance( ).mostRecentlyProcessedSegmentDuration {
                        SpeechRecognizer.sharedInstance( ).mostRecentlyProcessedSegmentDuration = lastSegment.duration
                        
                        SpeechRecognizer.sharedInstance( ).delagate?.speechRecognizer?(type: .Speaking , message: nil)
                        
                        SpeechRecognizer.sharedInstance( ).StopRecording()
                    }else{
                        
                        print("StopRecording")
                    }
                }
                
                if isFinal{
                    print("isFinal2: \(isFinal)")
                    
                    SpeechRecognizer.sharedInstance( ).delagate?.speechRecognizer?(type: .EndSpeak , message: speechingStr)
                }
            }
            
            print("error: \(error)")

        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) {
            (buffer, when) in
            SpeechRecognizer.sharedInstance( ).recognitionRequest?.append(buffer)
        }
        
        engine.prepare()
        
        do {
            try engine.start()
        } catch {
            SpeechRecognizer.sharedInstance( ).delagate?.speechRecognizer?(type: .AudioEngineCouldNotStart , message: "audioEngine couldn't start because of an error.")
        }
        
        SpeechRecognizer.sharedInstance( ).delagate?.speechRecognizer?(type: .Listening , message: nil)
        
    }
}


//==============================//
// MARK:      SFSpeech Recognizer Delegate
//=============================//
extension SpeechRecognizer : SFSpeechRecognizerDelegate {
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            SpeechRecognizer.sharedInstance( ).delagate?.speechRecognizer?(type: .Listening , message: "available")
        } else {
            SpeechRecognizer.sharedInstance( ).delagate?.speechRecognizer?(type: .StartSpeak , message: "unAvailable")
        }
    }
}

//==============================//
// MARK:      AV Speech Synthesizer Delegate
//=============================//
extension SpeechRecognizer : AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
         SpeechRecognizer.sharedInstance( ).delagate?.speechRecognizer?(type: .EndPlayback , message: nil)
    }
}





