//
//  ViewController.swift
//  RPG Attack!
//
//  Created by Gergely Mor Bacskai on 16/05/16.
//  Copyright © 2016 bacskai. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    //starting screen
    @IBOutlet weak var newGameLbl: UILabel!
    @IBOutlet weak var newGameBtn: UIButton!
    @IBOutlet weak var splashScreenBg: UIImageView!
    
    //graves to hide & unhide
    @IBOutlet weak var p2Grave: UIImageView!
    @IBOutlet weak var p1Grave: UIImageView!
    
    //to unhide on start
    @IBOutlet weak var p2Character: UIImageView!
    @IBOutlet weak var p1Character: UIImageView!
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var textHolderBg: UIImageView!
    @IBOutlet weak var p2HpLbl: UILabel!
    @IBOutlet weak var p1HpLbl: UILabel!

    @IBOutlet weak var p1AttackBtn: UIButton!
    @IBOutlet weak var p2AttackBtn: UIButton!
    
    //Sorry for these two
    @IBOutlet weak var p1AttackBtnLbl: UILabel!
    @IBOutlet weak var p2AttackBtnLbl: UILabel!
    
    @IBOutlet weak var backGroundImg: UIImageView!
    @IBOutlet weak var groundImg: UIImageView!
    
    var p1: Character!
    var p2: Character!
    var hitSound: AVAudioPlayer!
    var deathSound: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hitPath = NSBundle.mainBundle().pathForResource("sword", ofType: "wav")
        let hitSoundURL = NSURL(fileURLWithPath: hitPath!)
        let deathPath = NSBundle.mainBundle().pathForResource("death", ofType: "wav")
        let deathSoundURL = NSURL(fileURLWithPath: deathPath!)
        do{
            try hitSound = AVAudioPlayer(contentsOfURL: hitSoundURL)
            hitSound.prepareToPlay()
            try deathSound = AVAudioPlayer(contentsOfURL: deathSoundURL)
            deathSound.prepareToPlay()
        }catch let err as NSError{
            print(err.debugDescription)
        }

        
    }

    @IBAction func onP1AttackTapped(sender: AnyObject) {
        if p1.isAlive(){
            let attack = Int(arc4random_uniform(UInt32(p1.maxAttackPwr))+10)
            if p2.getInjured(attack) == true{
                infoLbl.text = "Orc attacked Knight for \(attack) HP!"
                p2HpLbl.text = "\(p2.hp) HP"
                playHitSound()
            }
            else{
                infoLbl.text = "Orc killed Knight!"
                p2HpLbl.text = "0 HP"
                p2Character.hidden = true
                p2Grave.hidden = false
                playDeathSound()
                
                NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(ViewController.gameEnd), userInfo: nil, repeats: false)
            }
        }
    }

    @IBAction func onP2AttackTapped(sender: AnyObject) {
        if p2.isAlive(){
            let attack = Int(arc4random_uniform(UInt32(p2.maxAttackPwr))+10)
            if p1.getInjured(attack) == true{
                infoLbl.text = "Knight attacked Orc for \(attack) HP!"
                p1HpLbl.text = "\(p1.hp) HP"
                playHitSound()
            }
            else{
                infoLbl.text = "Knight killed Orc!"
                p1HpLbl.text = "0 HP"
                p1Character.hidden = true
                p1Grave.hidden = false
                playDeathSound()
                
                NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(ViewController.gameEnd), userInfo: nil, repeats: false)
            }
        }
    }
    
    @IBAction func onNewGameTapped(sender: AnyObject) {
        
        gameInit()
    }
    
    func gameInit(){
        p1 = Character(hp: 100, maxAttackPwr: 20)
        p2 = Character(hp: 100, maxAttackPwr: 20)
        p1HpLbl.text = "\(p1.hp)"
        p2HpLbl.text = "\(p2.hp)"
        
        newGameBtn.hidden = true
        newGameLbl.hidden = true
        splashScreenBg.hidden = true
        
        p1Character.hidden = false
        p2Character.hidden = false
        infoLbl.hidden = false
        textHolderBg.hidden = false
        p1HpLbl.hidden = false
        p2HpLbl.hidden = false
        p1AttackBtn.hidden = false
        p2AttackBtn.hidden = false
        p1AttackBtnLbl.hidden = false
        p2AttackBtnLbl.hidden = false
        backGroundImg.hidden = false
        groundImg.hidden = false
        
        p1Grave.hidden = true
        p2Grave.hidden = true
    }
    
    func gameEnd(){
        newGameBtn.hidden = false
        newGameLbl.hidden = false
        splashScreenBg.hidden = false
        
        p1Character.hidden = true
        p2Character.hidden = true
        infoLbl.hidden = true
        textHolderBg.hidden = true
        p1HpLbl.hidden = true
        p2HpLbl.hidden = true
        p1AttackBtn.hidden = true
        p2AttackBtn.hidden = true
        p1AttackBtnLbl.hidden = true
        p2AttackBtnLbl.hidden = true
        backGroundImg.hidden = true
        groundImg.hidden = true
        
        p1Grave.hidden = true
        p2Grave.hidden = true
    }
    
    func playHitSound(){
        if hitSound.playing{
            hitSound.stop()
        }
        hitSound.play()
    }
    
    func playDeathSound(){
        deathSound.play()
    }
    
}

