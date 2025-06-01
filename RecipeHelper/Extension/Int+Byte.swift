//
//  Int+Byte.swift
//  RecipeHelper
//
//  Created by Daniel Behar on 5/31/25.
//

extension Int {
    typealias Bytes = Int
    
    var megabytes: Bytes {
        self * 1024 * 1024
    }
    
    var gigabytes: Bytes {
        self * megabytes * 1024
    }
}
