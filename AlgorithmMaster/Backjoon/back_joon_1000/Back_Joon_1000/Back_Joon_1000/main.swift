//
//  main.swift
//  Back_Joon_1000
//
//  Created by Minseop Kim on 2020/12/04.
//

import Foundation

let num = readLine()?.split(separator: " ")

if let sol = num {
    let A = Int(sol[0])
    let B = Int(sol[1])
    
    let answer =  A! + B!
    print(answer)
}


