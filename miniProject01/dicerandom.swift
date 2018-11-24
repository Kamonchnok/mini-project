//
//  diceRandom.swift
//  miniProject01
//
//  Created by admin on 11/10/18.
//  Copyright © 2018 ICTSUIM. All rights reserved.
//

import Foundation
import UIKit
class diceRandom: UIViewController {
    
    
    @IBOutlet var diceView1: UIImageView!
    
    @IBOutlet var numRan: UILabel!
    @IBOutlet var resultLabel: UILabel!
    
    var randomDice1 : Int = 0
   
    
    let diceA = ["dice1","dice2","dice3","dice4","dice5","dice6"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        changeDice()
    }
    
    @IBAction func buttonRan(_ sender: UIButton) {
        print("funtion rollButton has been call")
        
        changeDice()
    }
    
    func changeDice(){
        
        randomDice1 = Int(arc4random_uniform(6))
        //Casting type Uint32 --> Int ด้วยคำสั่ง Int()
        
        diceView1.image =
            UIImage(named:diceA[randomDice1])
        
        if randomDice1 == 0
        {
            resultLabel.text = "มั่นคงในการตัดสินใจ"
            numRan.text = "1"
        }
        if randomDice1 == 1
        {
            resultLabel.text = "ต้องลดความดื้อและความอายลงบ้างจะดี "
            numRan.text = "2"
        }
        if randomDice1 == 2
        {
            resultLabel.text = "เหนื่อยและต่อสู้มากจึงจะสำเร็จ"
            numRan.text = "3"
        }
        if randomDice1 == 3
        {
            resultLabel.text = "เอาตัวรอดได้ดีมาก"
            numRan.text = "4"
        }
        if randomDice1 == 4
        {
            resultLabel.text = "เชื่อมั่นในตัวเองค่อนข้างสูง"
            numRan.text = "5"
        }
        if randomDice1 == 5
        {
            resultLabel.text = "มีจินตนาการเป็นคนช่างฝัน"
            numRan.text = "6"
        }
        
    }//end func 
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        changeDice()
    }
}

