//
//  Array+Only.swift
//  Memorize
//
//  Created by UNDaniel on 14/3/21.
//

import Foundation

extension Array {
    var only: Element? {
        if self.count == 1 {
            return first
        } else {
            return nil
        }
    }
    
}
