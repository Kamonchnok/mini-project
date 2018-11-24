//
//  QuesstionController.swift
//  miniProject01
//
//  Created by admin on 11/10/18.
//  Copyright © 2018 ICTSUIM. All rights reserved.
//

import Foundation
import UIKit
class QuesstionController : UIViewController  {
    
    @IBOutlet var viewLabel: UILabel!
    @IBOutlet var cCorrectLabel: UILabel!
    @IBOutlet var cWrongLabel: UILabel!
    @IBOutlet var choiceLabel: UILabel!
    @IBOutlet var countingLine: UIView!
    @IBOutlet var scoreLabel: UILabel!
    
    //////////////////////////////////
    
    @IBOutlet var timeCountText: UILabel!
    @IBOutlet var timeLine: UIView!
    /////////////////////////////////
    
    let allQuestion = QuestionB()
    var pickedAnswer : Bool = false
    var score : Int = 0
    var countCorrect : Int = 0
    var countWrong : Int = 0
    
    var questionNumber : Int = 0
    
    //////////////////////////////
    
    var timer = Timer()
    
    var limitTime = 30

    
    ////////////////////////////
    
    var checkStatusToPlay = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        updateUI()
    }
    ///////////////////////////////
    @objc func processTimer() {
        if limitTime > 0 {
            //ถ้าเวลายังมากกว่า 0 ก็ให้นับถอยหลัง คือลบค่าไปเรื่อยๆ
            limitTime -= 1
            timeCountText.text = "⏱ Timer: \(limitTime)"
        }else if limitTime == 0{
            checkStatusToPlay = false
            //ถ้าเวลาเป็น 0 ก็ให้เปลี่ยนสถานะเป็น False เพื่อให้กดเล่นต่อไม่ได้
                let alert = UIAlertController(title: "End Game", message: "หมดเวลา  \n คุณได้คะแนน \(score) คะแนน \n เล่นอีกรอบ", preferredStyle:.alert)
                
                let restartAction = UIAlertAction(title: "Restart", style: .default, handler:{UIAlertAction in self.startOver()})
                
                alert.addAction(restartAction)
                
                present(alert,animated: true,completion: nil)
            
            
        }else{
            timer.invalidate()
            //นอกเหลือจากนั้น ให้หยุดเวลา
        }
    }
    ///////////////////////////////
    @IBAction func answerButton(_ sender: UIButton) {
        
        if checkStatusToPlay {
        //ถ้ากดปุ่มจริง tag = 1
        if sender.tag == 1 {
            pickedAnswer = true
        }else if sender.tag == 2{
            //ถ้ากดปุ่มเท็จ tag = 2
            pickedAnswer = false
        }
        checkAnswer()
        questionNumber += 1
        updateUI()
        
       
        }
    }
    
    func checkAnswer() {
        let correctAnswer = allQuestion.list[questionNumber].answer
        if correctAnswer == pickedAnswer {
            print("ถูก")
            score += 1
            countCorrect += 1
            
            
            ProgressHUD.showSuccess("ถูกต้อง")
            
        }else{
            print("ผิด")
            countWrong += 1
            
            ProgressHUD.showSuccess("ผิด")
        }
        
    }
    
    func updateUI() {
        scoreLabel.text = String(score)
        cCorrectLabel.text = "จำนวนข้อที่ถูก = " + String(countCorrect) //+ "=" + String ((Float(countCorrect))*100)
        cWrongLabel.text = "จำนวนข้อที่ผิด = " + String(countWrong) //+ "=" + String ((Float(countCorrect)/5)*100)
        choiceLabel.text = "ทำไปแล้ว \(questionNumber)/20"
        
        countingLine.frame.size.width = (view.frame.size.width / 20) * CGFloat(questionNumber)
        
        //timeLine.frame.size.width = (view.frame.size.width + 20) * CGFloat(limitTime)
        
        nextQuestion()
        
    }
    
    
    func nextQuestion(){
        
        if questionNumber <= 19{
            viewLabel.text = allQuestion.list[questionNumber].questionText
        }else {
            
            let alert = UIAlertController(title: "End Game", message: "จบคำถามแล้ว  \n คุณได้คะแนน \(score) คะแนน \n เล่นอีกรอบ", preferredStyle:.alert)
            
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler:{UIAlertAction in self.startOver()})
            
            alert.addAction(restartAction)
            
            present(alert,animated: true,completion: nil)
            
            
        }//end else
        
    }//end nextQuestion

    func startOver(){
        
        questionNumber = 0
        score = 0
        countCorrect = 0
        countWrong = 0
        
        updateUI()
        
        checkStatusToPlay = true
        limitTime = 30

        
    }
    
    
    @IBAction func startPressed(_ sender: UIButton) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,selector: #selector(QuesstionController.processTimer), userInfo: nil,repeats: true)
        
        checkStatusToPlay = true
        
       
    }

    
}
