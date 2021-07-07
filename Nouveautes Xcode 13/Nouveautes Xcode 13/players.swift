//
//  Autocompletion.swift
//  Nouveautes Xcode 13
//
//  Created by Maxime Britto on 21/06/2021.
//

import Foundation

struct Player {
    let name:String
    var score = 0
    var health = 100
    var level = 1
    var weapon = Weapon(name: "Batte de baseball", power: 1)
    
    mutating func attack(player:inout Player) {
        player.receiveHit(strenght: level * weapon.fire())
    }
    
    mutating func receiveHit(strenght:Int) {
        health -= min(health, strenght)
    }
}

struct Weapon {
    let name:String
    let power:Int
    var amunitionCount = 100
    
    mutating func fire(times:Int = 1) -> Int {
        var shotPower = 0
        for _ in 0..<times {
            shotPower += power
            amunitionCount -= 1
        }
        return shotPower
    }
}


