//
//  Character.swift
//  RPG Attack!
//
//  Created by Gergely Mor Bacskai on 16/05/16.
//  Copyright © 2016 bacskai. All rights reserved.
//

import Foundation

class Character {
    
    private var _hp: Int
    private var _maxAttackPwr: Int
    
    init(hp: Int, maxAttackPwr: Int){
        self._hp = hp
        self._maxAttackPwr = maxAttackPwr
    }
    
    var hp: Int {
        get {
            return _hp
        }
    }
    
    var maxAttackPwr: Int {
        get{
            return _maxAttackPwr
        }
    }
    
    func getInjured(hp: Int) -> Bool{
        _hp -= hp
        if _hp>0{
            return true
        }
        return false
    }
    
    func isAlive() -> Bool {
        return _hp>0
    }
    
}