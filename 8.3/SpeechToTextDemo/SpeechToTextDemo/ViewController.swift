//
//  ViewController.swift
//  SpeechToTextDemo
//
//  Created by SHUN on 12/2/16.
//  Copyright © 2016 q2650108. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //==============================//
    // MARK:     Pirvate Property
    //=============================//
    
    private var listData : [MessageEntity] = [MessageEntity]()
    
    /// Listening Mask View
    private var listeningMaskView : UIView = UIView()
    
    private var window : UIWindow  {
        get {
            return (UIApplication.shared.delegate as! AppDelegate ).window!
        }
    }
    
    private var imageViewListening : UIImageView {
        get {
            return self.listeningMaskView.subviews[0] as! UIImageView
        }
    }
    
    private var labelFontSize : CGFloat  {
        get {
            let screenSize = UTL.getScreenSize()
            var size : CGFloat  = 0.0
            
            if screenSize == 4 {
                size = 14
            }else if screenSize == 4.7 {
                size = 16
            }else if screenSize == 5.5 {
                size = 18
            }
            
            return size
        }
    }
    
    //==============================//
    // MARK:     Public Property
    //=============================//
    
    private var selectedLastMenuIndex : Int?
    
    //==============================//
    // MARK:     Layout Property
    //=============================//
    
    @IBOutlet weak var viewUnderlineMenu: UIViewUnderlineMenu!
    
    /// Message Container
    @IBOutlet weak var tableView: UITableView!
    
    //==============================//
    // MARK:     Action
    //=============================//
    
    
    //==============================//
    // MARK:     Life Cycle
    //=============================//
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initValue()
        
        
        SpeechRecognizer.sharedInstance(delegate: self).getAuthorization()
        //initTestData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //initViewListening()
        setAIMessage(msg: "Say something, I'm listening!")
        refreshTable()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit{
        print("\( type(of: self) ) deinit")
        
        
        if SpeechRecognizer.sharedInstance().isAudioRunning() {
            /// Stop Recording
            SpeechRecognizer.sharedInstance().StopRecording()
        }
        
        /// Remove viewListening
        //        setListeningAnimation(status: false)
        //        self.listeningMaskView.subviews.forEach( {$0.removeFromSuperview() } )
    }
    
    //==============================//
    // MARK:      Private Func
    //=============================//
    
    private func initValue(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.isHidden = true
        
        viewUnderlineMenu.delegate = self
        
    }
    
    private func initTestData(){
        
        listData.append( MessageEntity(isAI: true   , message: "壹", time: "08:30 AM") )
        listData.append( MessageEntity(isAI: true   , message: "壹貳", time: "08:30 AM") )
        listData.append( MessageEntity(isAI: true   , message: "壹貳叄", time: "08:30 AM") )
        listData.append( MessageEntity(isAI: true   , message: "壹貳叄肆", time: "08:30 AM") )
        listData.append( MessageEntity(isAI: true   , message: "壹貳叄肆伍", time: "08:30 AM") )
        listData.append( MessageEntity(isAI: true   , message: "壹貳叄肆伍陸", time: "08:30 AM") )
        listData.append( MessageEntity(isAI: true   , message: "壹貳叄肆伍陸柒", time: "08:30 AM") )
        listData.append( MessageEntity(isAI: true   , message: "壹貳叄肆伍陸柒捌", time: "08:30 AM") )
        listData.append( MessageEntity(isAI: true   , message: "壹貳叄肆伍陸柒捌玖", time: "08:30 AM") )
        listData.append( MessageEntity(isAI: true   , message: "壹貳叄肆伍陸柒捌玖拾", time: "08:30 AM") )
        listData.append( MessageEntity(isAI: true   , message: "壹貳叄肆伍陸柒捌玖拾佰", time: "08:30 AM") )
        listData.append( MessageEntity(isAI: true   , message: "壹貳叄肆伍陸柒捌玖拾佰仟", time: "08:30 AM") )
        listData.append( MessageEntity(isAI: true   , message: "壹貳叄肆伍陸柒捌玖拾佰仟萬", time: "08:30 AM") )
        listData.append( MessageEntity(isAI: true   , message: "壹貳叄肆伍陸柒捌玖拾佰仟萬億", time: "08:30 AM") )
        
        listData.append( MessageEntity(isAI: false   , message: "壹", time: "08:30 AM") )
        listData.append( MessageEntity(isAI: false   , message: "壹貳", time: "08:30 AM") )
        listData.append( MessageEntity(isAI: false   , message: "壹貳叄", time: "08:30 AM") )
        listData.append( MessageEntity(isAI: false   , message: "壹貳叄肆", time: "08:30 AM") )
        listData.append( MessageEntity(isAI: false   , message: "壹貳叄肆伍", time: "08:30 AM") )
        listData.append( MessageEntity(isAI: false   , message: "壹貳叄肆伍陸", time: "08:30 AM") )
        listData.append( MessageEntity(isAI: false   , message: "壹貳叄肆伍陸柒", time: "08:30 AM") )
        listData.append( MessageEntity(isAI: false   , message: "壹貳叄肆伍陸柒捌", time: "08:30 AM") )
        listData.append( MessageEntity(isAI: false   , message: "壹貳叄肆伍陸柒捌玖", time: "08:30 AM") )
        listData.append( MessageEntity(isAI: false   , message: "壹貳叄肆伍陸柒捌玖拾", time: "08:30 AM") )
        listData.append( MessageEntity(isAI: false   , message: "壹貳叄肆伍陸柒捌玖拾佰", time: "08:30 AM") )
        listData.append( MessageEntity(isAI: false   , message: "壹貳叄肆伍陸柒捌玖拾佰仟", time: "08:30 AM") )
        listData.append( MessageEntity(isAI: false   , message: "壹貳叄肆伍陸柒捌玖拾佰仟萬", time: "08:30 AM") )
        listData.append( MessageEntity(isAI: false   , message: "壹貳叄肆伍陸柒捌玖拾佰仟萬億", time: "08:30 AM") )
        
        
        listData.append( MessageEntity(isAI: true   , message: "精選優質北冬蟲夏草加入國產新鮮CAS豬後腿肉", time: "08:30 AM") )
        listData.append( MessageEntity(isAI: true   , message: "陳A陳 黃B黃 林C林 施D施 李E李 范F范 王G王 王H王 洪I洪 ", time: "08:30 AM") )
        
        listData.append( MessageEntity(isAI: false  , message: "採真空包裝，不摻香精、不加色素、全面拒絕防腐劑，真實呈現飽滿肉質的原汁原味。", time: "08:30 AM") )
        listData.append( MessageEntity(isAI: false  , message: "以二比八的肥瘦肉質比例充填至天然豬腸衣中，汁香味美、口感十足！", time: "08:30 AM") )
        listData.append( MessageEntity(isAI: false  , message: "【黃金香腸】", time: "08:30 AM") )
        
        listData.append( MessageEntity(isAI: true   , message: "原價：200元，預購優惠價：140元", time: "08:30 AM") )
        listData.append( MessageEntity(isAI: true   , message: "預購日期：即日起 -12/13(二)12:00", time: "08:30 AM") )
        listData.append( MessageEntity(isAI: false   , message: "規格：半斤(300g，５根)/包，", time: "08:30 AM") )
        
        listData.append( MessageEntity(isAI: false   , message: "您還在詢問什麼時候可以購買嗎？", time: "08:30 AM") )
        listData.append( MessageEntity(isAI: true   , message: "您還在詢問黃金香腸好吃嗎？不要再問了，趕緊加入購買行列，", time: "08:30 AM") )
        
        listData.append( MessageEntity(isAI: true  , message: "祝各位旅途平安快樂，", time: "08:30 AM") )
        listData.append( MessageEntity(isAI: false  , message: "烏魚伯野生烏魚子及第一鰻波胭脂鰻", time: "08:30 AM") )
        listData.append( MessageEntity(isAI: true   , message: "還有新社冬菇、小果苦茶油、台灣黑豆茶、丸莊醬油、台灣紅藜、龍眼乾、薑黃粉、銀耳露、黑米王、蕃茄乾、", time: "08:30 AM") )
        
        listData.append( MessageEntity(isAI: true   , message: "還有新社冬菇、小果苦茶油、台灣黑豆茶、丸莊醬油、台灣紅藜、龍眼乾、薑黃粉、銀耳露、黑米王、蕃茄乾、", time: "08:30 AM") )
        
        listData.append( MessageEntity(isAI: true  , message: "黑鑽石熟成黑蒜、雲林縣農會花生湯、日月潭紅茶、冰烤蕃薯、雲林縣農會蜂蜜及有機米，", time: "08:30 AM") )
        
        listData.append( MessageEntity(isAI: true  , message: "黑鑽石熟成黑蒜、雲林縣農會花生湯、日月潭紅茶、冰烤蕃薯、雲林縣農會蜂蜜及有機米，", time: "08:30 AM") )
        
        
        listData.append( MessageEntity(isAI: false   , message: "日治時代持木茶區所留下的大葉種品種，香氣比阿薩姆更有層次感，前段是天然花香、中段是果香、後段是焦糖香，口感圓潤， 味道甘醇且有後韻，", time: "08:30 AM") )
        listData.append( MessageEntity(isAI: false   , message: "日治時代持木茶區所留下的大葉種品種，香氣比阿薩姆更有層次感，前段是天然花香、中段是果香、後段是焦糖香，口感圓潤， 味道甘醇且有後韻，", time: "08:30 AM") )
        listData.append( MessageEntity(isAI: true   , message: "日治時代持木茶區所留下的大葉種品種，香氣比阿薩姆更有層次感，前段是天然花香、中段是果香、後段是焦糖香，口感圓潤， 味道甘醇且有後韻，", time: "08:30 AM") )
        
        listData.append( MessageEntity(isAI: true   , message: "冰烤蕃薯:超人氣超夯超熱銷的道地台灣地瓜美食，冰烤蒸三吃、風味俱佳，拆封即食，方便又健康 ; 雲林縣農會蜂蜜:來自雲林縣農會，營養豐富、芳香甜美、夏日飲品的最佳天然好選擇。;雲林縣農會花生湯:採用雲林縣質地優良的花生，味道香醇、營養可口，冰飲、熱食皆適宜，是夏季消暑飲品、冬季滋補聖品。;日月潭紅茶－阿薩姆:為日本人從印度阿薩姆省引進的茶種，榮獲英國拍賣會獲選為高優質的茶。茶湯色朱紅艷麗，口感豐富濃郁香醇。", time: "08:30 AM") )
        
        listData.append( MessageEntity(isAI: true   , message: "冰烤蕃薯:超人氣超夯超熱銷的道地台灣地瓜美食，冰烤蒸三吃、風味俱佳，拆封即食，方便又健康 ; 雲林縣農會蜂蜜:來自雲林縣農會，營養豐富、芳香甜美、夏日飲品的最佳天然好選擇。;雲林縣農會花生湯:採用雲林縣質地優良的花生，味道香醇、營養可口，冰飲、熱食皆適宜，是夏季消暑飲品、冬季滋補聖品。;日月潭紅茶－阿薩姆:為日本人從印度阿薩姆省引進的茶種，榮獲英國拍賣會獲選為高優質的茶。茶湯色朱紅艷麗，口感豐富濃郁香醇。", time: "08:30 AM") )
        
        listData.append( MessageEntity(isAI: false   , message: "冰烤蕃薯:超人氣超夯超熱銷的道地台灣地瓜美食，冰烤蒸三吃、風味俱佳，拆封即食，方便又健康 ; 雲林縣農會蜂蜜:來自雲林縣農會，營養豐富、芳香甜美、夏日飲品的最佳天然好選擇。;雲林縣農會花生湯:採用雲林縣質地優良的花生，味道香醇、營養可口，冰飲、熱食皆適宜，是夏季消暑飲品、冬季滋補聖品。;日月潭紅茶－阿薩姆:為日本人從印度阿薩姆省引進的茶種，榮獲英國拍賣會獲選為高優質的茶。茶湯色朱紅艷麗，口感豐富濃郁香醇。", time: "08:30 AM") )
        
    }
    
    private func initViewListening(){
        
        /// Listening Mask View
        /// Set frame
        listeningMaskView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size:  CGSize(width: window.frame.width , height: window.frame.height) )
        /// Set background Color
        listeningMaskView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        
        let imageViewListening : UIImageView = UIImageView()
        /// get min side from window width or window height
        let minSide =  min( listeningMaskView.frame.width , listeningMaskView.frame.height )
        let side = minSide * 0.15
        /// Set Frame
        imageViewListening.bounds = CGRect(x: 0, y: 0, width: side, height: side)
        /// Set Center
        imageViewListening.center = CGPoint(x: window.frame.width / 2 , y: window.frame.height / 2 )
        
        /// Set the Rounded Corners
        imageViewListening.layer.cornerRadius = imageViewListening.frame.width / 2
        
        imageViewListening.layer.masksToBounds = true
        
        imageViewListening.animationImages = [ UIImage(named: "main_center_icon_ecg_a")! ,
                                               UIImage(named: "main_center_icon_ecg_b")! ,
                                               UIImage(named: "main_center_icon_ecg_c")! ]
        
        imageViewListening.animationDuration = 1.0
        
        
        listeningMaskView.addSubview(imageViewListening)
    }
    
    /// Toggle the Animation
    func setListeningAnimation( status : Bool) {
        if status{
            imageViewListening.startAnimating()
        }else{
            imageViewListening.stopAnimating()
        }
    }
    
    ///  Caculate Label
    ///
    /// - Parameters:
    ///   - label: Label
    ///   - width: Frame Width
    /// - Returns: size , lineNumber
    func caculateLabel(  label  : UILabel , width : CGFloat ) ->  ( size : CGSize , lineNumber : Int )  {
        /// Padding Left and Right
        let padding :CGFloat = 10
        
        label.numberOfLines = 0
        let mutliSize = label.attributedText?.boundingRect(with: CGSize(width: width - padding , height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil).size
        
        /// Get singel Hieght
        let singleLabel = UILabel()
        singleLabel.bounds = label.bounds
        singleLabel.text  = label.text
        singleLabel.font = label.font
        singleLabel.numberOfLines = 1
        
        let singleSize = singleLabel.attributedText?.boundingRect(with: CGSize(width: singleLabel.frame.width - padding , height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil).size
        
        if let _multiSize = mutliSize , let _singleSize = singleSize {
            let _lineNumber = _multiSize.height / _singleSize.height
            return  ( _multiSize , Int( _lineNumber ) )
        }else {
            return  ( CGSize.zero , 0 )
        }
    }
    
    
    /// get Now Time Format
    ///
    /// - Returns: "h:mm a"
    private func getNowTimeFormat() -> String {
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        let time = formatter.string(from: date)
        
        return time
    }
    
    /// Refresh Table
    func refreshTable(){
        DispatchQueue.global(qos: .background).async {
            [unowned self]
            () -> Void in
            
            DispatchQueue.main.async {
                
                () -> Void in
                self.tableView.reloadData(){
                    self.tableView.isHidden = false
                    
                    if self.listData.count > 0 {
                        
                        let lastIndex = IndexPath(row: self.listData.count - 1 , section: 0)
                        self.tableView.scrollToRow(at: lastIndex, at: .bottom , animated: true)
                    }
                }
            }
        }
    }
    
    //==============================//
    // MARK:      Public Func
    //=============================//
    
    func getListData() -> [MessageEntity]{
        return listData
    }
    
    func getFontSize() -> CGFloat {
        return labelFontSize
    }
    
    func setAIMessage( msg : String ){
        self.listData.append( MessageEntity(isAI: true , message: msg , time: getNowTimeFormat() ) )
        refreshTable()
    }
    
    func setUserMessage( msg : String ){
        self.listData.append( MessageEntity(isAI: false , message: msg , time: getNowTimeFormat() ) )
        refreshTable()
    }
    
    
    func getSelectedLastMenuIndex() -> Int? {
        return selectedLastMenuIndex
    }
    
    func setSelectedLastMenuIndex( index : Int? ){
        selectedLastMenuIndex = index
    }
    
    
    
    //==============================//
    // MARK:      TableView Cell Common Setting
    //=============================//
    
    func setCellLabel( index : Int , singleLabel : UILabel , multiLabel : UILabel , timeLabel : UILabel ){
        
        /// Set Message
        singleLabel.text = listData[index].message
        multiLabel.text = listData[index].message
        
        /// Set Font Size
        singleLabel.font = UIFont.systemFont( ofSize: self.labelFontSize  )
        multiLabel.font = UIFont.systemFont( ofSize: self.labelFontSize  )
        
        /// Set Line Spcaing
        singleLabel.setLineHeight(lineHeight: 1.25)
        multiLabel.setLineHeight(lineHeight: 1.25)
        
        /// Get Label Height
        //let singleInfo = caculateLabel( calculatelabel: singleLabel )
        let labelInfo = caculateLabel( label: multiLabel , width: multiLabel.frame.width )
        
        
        /// Set cellHeight and isSingleContent
        listData[index].isSingleContent = labelInfo.lineNumber > 1 ? false : true
        listData[index].cellHeight = labelInfo.size.height
        
        /// Set Visible
        singleLabel.isHidden = !listData[index].isSingleContent
        multiLabel.isHidden = listData[index].isSingleContent
        
        /// Clear Text
        if listData[index].isSingleContent {
            /// Singel
            multiLabel.text = nil
        }else{
            /// Multi
            singleLabel.text = nil
        }
        
        
        /// Set Label Round Single View
        singleLabel.layer.masksToBounds = true
        singleLabel.layer.shouldRasterize = true
        singleLabel.layer.cornerRadius = 5
        
        multiLabel.layer.masksToBounds = true
        multiLabel.layer.shouldRasterize = true
        multiLabel.layer.cornerRadius = 5
        
        /// Set Time
        timeLabel.text = getListData()[index].time
        /// Set Font Size
        timeLabel.font = UIFont.systemFont( ofSize: self.labelFontSize - 4 )
        
    }
    
}

//==============================//
// MARK:      TableView Delegate
//=============================//
extension ViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let msg =  getListData()[indexPath.row].message
        
        if SpeechRecognizer.sharedInstance().isAudioRunning() {
            /// Stop Recording
            SpeechRecognizer.sharedInstance().StopRecording()
        }
        
        let  selectedStr = viewUnderlineMenu.getSelctedString(index: getSelectedLastMenuIndex() ?? 0 )
        let languageEnum = LocalEnum.toLocalEnum( str:  selectedStr )
        
        SpeechRecognizer.sharedInstance(delegate: self).startPlayBack(msg: msg , language: languageEnum.rawValue )
        
        
        self.tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if getListData()[indexPath.row].isSingleContent{
            return self.tableView.rowHeight
        }else{
            return UITableViewAutomaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
}

//==============================//
// MARK:      TableView DataSource
//=============================//
extension ViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getListData().count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell = UITableViewCell()
        
        if getListData().count > 0 {
            /// Index
            let index = indexPath.row
            
            
            if getListData()[index].isAI {
                /// Set AI
                let aITVCell = tableView.dequeueReusableCell(withIdentifier: "cellAI" , for: indexPath ) as! AITVCell
                
                /// Set Profile Image
                aITVCell.imageViewProfileAI.image = UIImage(named: "robot")
                /// Set Round View
                aITVCell.imageViewProfileAI.layer.shouldRasterize = true
                aITVCell.imageViewProfileAI.layer.cornerRadius = aITVCell.imageViewProfileAI.frame.width / 2
                aITVCell.imageViewProfileAI.layer.borderColor = UIColor.black.cgColor
                aITVCell.imageViewProfileAI.layer.borderWidth = 3
                
                /// Set Conten Label
                setCellLabel(index: index , singleLabel: aITVCell.labelAISingle, multiLabel: aITVCell.labelAIMulti , timeLabel: aITVCell.LabelAITime)
                
                cell = aITVCell
            }else{
                /// Set User
                let userTVCell = tableView.dequeueReusableCell(withIdentifier: "cellUser"  , for: indexPath ) as! UserTVCell
                
                /// Set Profile Image
                userTVCell.imageViewProfileUser.image = UIImage(named: "user")
                
                /// Set Conten Label
                setCellLabel(index: index , singleLabel: userTVCell.labelUserSingle, multiLabel: userTVCell.labelUserMulti , timeLabel: userTVCell.labelUserTime)
                
                cell = userTVCell
            }
        }
        
        return cell
    }
}


//==============================//
// MARK:      View Underline Delegate
//=============================//
extension ViewController : ViewUnderlineMenuDelegate{
    
    func viewUnderlineMenu(selectedIndex: Int, selectedValue: String) {
        print("selectedIndex: \(selectedIndex) , selectedValue : \(selectedValue)")
        
        let index = Int(selectedIndex)
        
        if let selectedLastMenuIndex = getSelectedLastMenuIndex() {
            if selectedLastMenuIndex != index {
                /// Set SpeechRecognizer Language
                SpeechRecognizer.sharedInstance(delegate: self).setLanguage(local:  LocalEnum.toLocalEnum( str: selectedValue ) )
                /// Stop Recording
                SpeechRecognizer.sharedInstance(delegate: self).StopRecording()
                
                setAIMessage(msg: "Say something, I'm listening!")
            }
            
        }else{
            /// Set SpeechRecognizer Language
            SpeechRecognizer.sharedInstance(delegate: self).setLanguage(local:  LocalEnum.toLocalEnum( str: selectedValue ) )
        }
        
        setSelectedLastMenuIndex(index: index)
        
        /// start Recording
        SpeechRecognizer.sharedInstance(delegate: self).startRecording()
    }
}


//==============================//
// MARK:      Speech Recognizer Delegate
//=============================//
extension ViewController : SpeechRecognizerDelegate{
    
    func speechRecognizer(type: SpeechRecognizerTypeEnum, message: String?) {
        let msg = message ?? ""
        print("type : \(type.rawValue) , message : \(message)")
        
        
        switch type {
        case SpeechRecognizerTypeEnum.Denied:
            setAIMessage(msg: msg )
        case SpeechRecognizerTypeEnum.NotDetermined:
            setAIMessage(msg: msg)
        case SpeechRecognizerTypeEnum.Restricted:
            setAIMessage(msg: msg)
        case SpeechRecognizerTypeEnum.UnsetAudioSessionProperties:
            setAIMessage(msg: msg)
        case SpeechRecognizerTypeEnum.Authorized:
            /// get  selected item , to Set SpeechRecognizer Language
            viewUnderlineMenu.getSelectedItem()
            
        case SpeechRecognizerTypeEnum.Listening :
            break
        case SpeechRecognizerTypeEnum.StartSpeak :
            break
            
        //setListeningAnimation(status: true)
        case SpeechRecognizerTypeEnum.EndSpeak :
            setUserMessage(msg: msg)
            
            let  selectedStr = viewUnderlineMenu.getSelctedString(index: getSelectedLastMenuIndex() ?? 0 )
            let languageEnum = LocalEnum.toLocalEnum( str:  selectedStr )
            SpeechRecognizer.sharedInstance(delegate: self).startPlayBack(msg: msg , language: languageEnum.rawValue )
            
        //setListeningAnimation(status: false)
        case SpeechRecognizerTypeEnum.Speaking :
            break
            
        case SpeechRecognizerTypeEnum.EndPlayback :
            viewUnderlineMenu.getSelectedItem()
            
        default :
            setAIMessage(msg: "UnHanlde Event")
        }
    }
}



