//
//  Rational.swift
//  Recipes
//
//  Created by Kevin Tierney on 3/25/22.
//

import Foundation

struct Rational {
    
    static func greatestCommonDivisor(_ a: Int, _ b: Int) -> Int{
        
        // GCD(0,b) = b
        if a == 0 {return b}
        
        //GCD(a,0) = a
        
        if b == 0 {return a}
        
        // otherwise, GCD(a,b) = GCD(b,remainder)
        
        return greatestCommonDivisor(b, a % b)
    }
}
 
