//
//  ViewController.swift
//  tic_tac_toe
//
//  Created by AKI on 2014/11/11.
//  Copyright (c) 2014年 AKI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.resetBtnClick(resetBtn)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBOutlet var lblMessage: UILabel!
    @IBOutlet var btn01: UIButton!
    @IBOutlet var btn02: UIButton!
    @IBOutlet var btn03: UIButton!
    @IBOutlet var btn04: UIButton!
    @IBOutlet var btn05: UIButton!
    @IBOutlet var btn06: UIButton!
    @IBOutlet var btn07: UIButton!
    @IBOutlet var btn08: UIButton!
    @IBOutlet var btn09: UIButton!
    @IBOutlet var resetBtn: UIButton!
    
    var plays:[Int] = [Int]()
    var done = false
    var isAIRunning = false
    
    
    @IBAction func btnClick(sender: UIButton) {

        if(!done && !isAIRunning && plays[sender.tag]<1){
            setMarkForSlot(sender.tag, player:1)
            checkForWin()
            if(!done){
                AI_Run()
                checkForWin()
            }
            
        }
        
        
    }
    
    @IBAction func resetBtnClick(sender: UIButton) {
        btn01.setTitle("", forState: UIControlState.Normal)
        btn02.setTitle("", forState: UIControlState.Normal)
        btn03.setTitle("", forState: UIControlState.Normal)
        btn04.setTitle("", forState: UIControlState.Normal)
        btn05.setTitle("", forState: UIControlState.Normal)
        btn06.setTitle("", forState: UIControlState.Normal)
        btn07.setTitle("", forState: UIControlState.Normal)
        btn08.setTitle("", forState: UIControlState.Normal)
        btn09.setTitle("", forState: UIControlState.Normal)
        
        lblMessage.hidden = true
        done = false
        isAIRunning = false
        
        //預設0為空 1為玩家  2為電腦
        plays = [0,0,0,0,0,0,0,0,0]
      
        
    }
    
    func setMarkForSlot(slot:Int,player:Int){
        var SlotMark = player==1 ?"O":"X"

        plays[slot] = player;
        
        switch slot{
        case 0:
            btn01.setTitle(SlotMark, forState: UIControlState.Normal)
        case 1:
            btn02.setTitle(SlotMark, forState: UIControlState.Normal)
        case 2:
            btn03.setTitle(SlotMark, forState: UIControlState.Normal)
        case 3:
            btn04.setTitle(SlotMark, forState: UIControlState.Normal)
        case 4:
            btn05.setTitle(SlotMark, forState: UIControlState.Normal)
        case 5:
            btn06.setTitle(SlotMark, forState: UIControlState.Normal)
        case 6:
            btn07.setTitle(SlotMark, forState: UIControlState.Normal)
        case 7:
            btn08.setTitle(SlotMark, forState: UIControlState.Normal)
        case 8:
            btn09.setTitle(SlotMark, forState: UIControlState.Normal)
        default:
            btn05.setTitle(SlotMark, forState: UIControlState.Normal)
        }
        
    }
    
    func checkForWin(){
        
        var whoWon = ["User":1,"Computer":2]
       
        for (key,value) in whoWon{
            
            let row1 = (plays[0]==value && plays[1]==value && plays[2]==value)
            let row2 = (plays[3]==value && plays[4]==value && plays[5]==value)
            let row3 = (plays[6]==value && plays[7]==value && plays[8]==value)
            let col1 = (plays[0]==value && plays[3]==value && plays[6]==value)
            let col2 = (plays[1]==value && plays[4]==value && plays[7]==value)
            let col3 = (plays[2]==value && plays[5]==value && plays[8]==value)
            let dia1 = (plays[0]==value && plays[4]==value && plays[8]==value)
            let dia2 = (plays[2]==value && plays[4]==value && plays[6]==value)
            
            println(row1)
            println(row2)
            println(row3)
            
            println(col1)
            println(col2)
            println(col3)
            
            println(dia1)
            println(dia2)
            
            println(plays)
            
            if(row1 || row2 || row3 || col1 || col2 || col3 || dia1 || dia2){
                done = true
                lblMessage.text = key + " win"
                lblMessage.hidden = false
                resetBtn.hidden = false
                
                break
            }
            
        }
       
        
    }
    
    func AI_Run(){
        
        isAIRunning = true
        
        //差一子就獲勝時要直接下取勝點
        //220,202,022
        
        var selected = self.twoInLine(2)
        
        if(selected != -1){
            setMarkForSlot(selected, player:2)
        }else{
        
            //阻擋user的取勝點
            selected = self.twoInLine(1)
        
            if(selected != -1){
                setMarkForSlot(selected, player:2)
            }else{
                //隨便找空白的地方亂下
                var emptySlot:[Int] = []
                
                var i = 0
                for(i==0;i<9;++i){
                    if(plays[i]==0){
                        emptySlot.append(i)
                    }
                }
                
                
                if(emptySlot.count == 0){
                    done = true;
                    lblMessage.text = "Fair Game"
                    lblMessage.hidden = false
                }else{
                    let x = UInt32(emptySlot.count)
                    let randomNum = Int(arc4random_uniform(x))
                    println(x)
                    println(randomNum)
                    let select = emptySlot[randomNum]
                    setMarkForSlot(select, player:2)
                    
                }
                
            }
        }
        
        isAIRunning = false
        
    }

    func twoInLine(who:Int)->Int{
        
        println(plays)
        
        if(plays[0]==who && plays[1]==who && plays[2]==0 ){
            return 2
        }else if(plays[0]==who && plays[1]==0 && plays[2]==who){
            return 1
        }else if(plays[0]==0 && plays[1]==who && plays[2]==who){
            return 0
        }else if(plays[3]==who && plays[4]==who && plays[5]==0){
            return 5
        }else if(plays[3]==who && plays[4]==0 && plays[5]==who){
            return 4
        }else if(plays[3]==0 && plays[4]==who && plays[5]==who){
            return 3
        }else if(plays[6]==who && plays[7]==who && plays[8]==0){
            return 8
        }else if(plays[6]==who && plays[7]==0 && plays[8]==who){
            return 7
        }else if(plays[6]==0 && plays[7]==who && plays[8]==who){
            return 6
        }else if(plays[0]==who && plays[3]==who && plays[6]==0){
            return 6
        }else if(plays[0]==who && plays[3]==0 && plays[6]==who){
            return 3
        }else if(plays[0]==0 && plays[3]==who && plays[6]==who){
            return 0
        }else if(plays[1]==who && plays[4]==who && plays[7]==0){
            return 7
        }else if(plays[1]==who && plays[4]==0 && plays[7]==who){
            return 4
        }else if(plays[1]==0 && plays[4]==who && plays[7]==who){
            return 1
        }else if(plays[2]==who && plays[5]==who && plays[8]==0){
            return 8
        }else if(plays[2]==who && plays[5]==0 && plays[8]==who){
            return 5
        }else if(plays[2]==0 && plays[5]==who && plays[8]==who){
            return 2
        }
        else if(plays[0]==who && plays[4]==who && plays[8]==0){
            return 8
        }else if(plays[0]==who && plays[4]==0 && plays[8]==who){
            return 4
        }else if(plays[0]==0 && plays[4]==who && plays[8]==who){
            return 0
        }else if(plays[2]==who && plays[4]==who && plays[6]==0){
            return 6
        }else if(plays[2]==who && plays[4]==0 && plays[6]==who){
            return 4
        }else if(plays[2]==0 && plays[4]==who && plays[6]==who){
            return 2
        }
        
        return -1
    }
    
}

