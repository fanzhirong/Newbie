//
//  ViewController.swift
//  Speech Assessment
//
//  Created by Chakery on 16/2/18.
//  Copyright © 2016年 Chakery. All rights reserved.
//

import UIKit
import SWXMLHash

class ViewController: UIViewController {
    @IBOutlet weak var soundButton: UIButton!
    @IBOutlet weak var resultTextView: UITextView!
    /// 评测对象
    let speechEvaluator: IFlySpeechEvaluator = IFlySpeechEvaluator.sharedInstance() as! IFlySpeechEvaluator
    /// 数据源
    var datasource: NSMutableData = NSMutableData()
    ///
    let soundStr = "Alternatively, you can look up an element with specific attributes."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configSpeechEvaluator()
        
        soundButton.addTarget(self, action: "touchDown", forControlEvents: .TouchDown)
        soundButton.addTarget(self, action: "touchDragExit", forControlEvents: [.TouchUpInside, .TouchUpOutside])
        soundButton.setTitle("按下说话", forState: .Normal)
        soundButton.setTitle("松开评测", forState: .Highlighted)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func configSpeechEvaluator() {
        speechEvaluator.delegate = self
        //清空参数
        speechEvaluator.setParameter("", forKey: IFlySpeechConstant.PARAMS())
        //设置评测采样率
        speechEvaluator.setParameter("16000", forKey: IFlySpeechConstant.SAMPLE_RATE())
        //设置评测题目编码: gb2312、utf-8
        speechEvaluator.setParameter("utf-8", forKey: IFlySpeechConstant.TEXT_ENCODING())
        //设置评测题目结果格式,目前仅支持xml
        speechEvaluator.setParameter("xml", forKey: IFlySpeechConstant.ISE_RESULT_TYPE())
        //设置评测前端点超时: 前端点超时,默认 5000ms
        speechEvaluator.setParameter("5000", forKey: IFlySpeechConstant.VAD_BOS())
        //设置评测后端点超时: 后端点超时,默认 1800ms
        speechEvaluator.setParameter("1800", forKey: IFlySpeechConstant.VAD_EOS())
        //设置评测前端点设置评测题型: read_syllable(单字,汉语专有)、 read_word(词语)、read_sentence(句子)
        speechEvaluator.setParameter("read_sentence", forKey: IFlySpeechConstant.ISE_CATEGORY())
        //设置评测语言: en_us(英语)、zh_cn(汉语)
        speechEvaluator.setParameter("en_us", forKey: IFlySpeechConstant.LANGUAGE())
        //设置评测结果级别: plain(仅英文)、complete,默认为 complete
        speechEvaluator.setParameter("complete", forKey: IFlySpeechConstant.ISE_RESULT_LEVEL())
        //设置评测超时: 录音超时,当录音达到时限将自动触发 vad 停止录音,默 认-1
        speechEvaluator.setParameter("-1", forKey: IFlySpeechConstant.SPEECH_TIMEOUT())
        //录音文件
        speechEvaluator.setParameter("eva.pcm", forKey: IFlySpeechConstant.ISE_AUDIO_PATH())
    }
    
    // 按下说话
    func touchDown() {
        let data = soundStr.dataUsingEncoding(NSUTF8StringEncoding)
        speechEvaluator.startListening(data, params: nil)
    }
    
    // 松开
    func touchDragExit() {
        speechEvaluator.stopListening()
    }
    
    ///	解析XML
    ///	- parameter xmlstr	需要解析的xml字符串
    ///	- returns: 返回结果字典
    func parser(sourcestr: String, xmlstr: String) -> [String : AnyObject] {
        let xml = SWXMLHash.lazy(xmlstr)
        let element = try? xml["xml_result"]["read_sentence"]["rec_paper"]["read_chapter"]["sentence"].withAttr("content", sourcestr)
        print("总分: \(element?["total_score"])")
        let _ = element?["word"].all.map {
            print( "\($0.element?.attributes["content"]) 得分: \($0.element?.attributes["total_score"])")
        }
        
        return ["":""]
    }
}

extension ViewController: IFlySpeechEvaluatorDelegate {
    /*!
    *  音量和数据回调
    *
    *  @param volume 音量
    *  @param buffer 音频数据
    */
    func onVolumeChanged(volume: Int32, buffer: NSData!) {
        
    }
    
    /*!
    *  开始录音回调
    *  当调用了`startListening`函数之后，如果没有发生错误则会回调此函数。如果发生错误则回调onError:函数
    */
    func onBeginOfSpeech() {
        
    }
    
    /*!
    *  停止录音回调
    *    当调用了`stopListening`函数或者引擎内部自动检测到断点，如果没有发生错误则回调此函数。
    *  如果发生错误则回调onError:函数
    */
    func onEndOfSpeech() {
        
    }
    
    /*!
    *  正在取消
    */
    func onCancel() {
        
    }
    
    /*!
    *  评测错误回调
    *    在进行语音评测过程中的任何时刻都有可能回调此函数，你可以根据errorCode进行相应的处理.
    *  当errorCode没有错误时，表示此次会话正常结束，否则，表示此次会话有错误发生。特别的当调用
    *  `cancel`函数时，引擎不会自动结束，需要等到回调此函数，才表示此次会话结束。在没有回调此函
    *  数之前如果重新调用了`startListenging`函数则会报错误。
    *
    *  @param errorCode 错误描述类
    */
    func onError(errorCode: IFlySpeechError!) {
        print("\n错误----> \(errorCode.errorCode) \n \(errorCode.errorDesc)\n")
    }
    
    /*!
    *  评测结果回调
    *   在评测过程中可能会多次回调此函数，你最好不要在此回调函数中进行界面的更改等操作，只需要将回调的结果保存起来。
    *
    *  @param results -[out] 评测结果。
    *  @param isLast  -[out] 是否最后一条结果
    */
    func onResults(results: NSData!, isLast: Bool) {
        if results.length > 0 {
            let chRsults = results.bytes
            let strResults = NSString(bytes: chRsults, length: results.length, encoding: NSUTF8StringEncoding)!
            resultTextView.text = strResults as String
            parser(soundStr, xmlstr: strResults as String)
        }
        if isLast {
            print("结束了")
        }
    }
}

