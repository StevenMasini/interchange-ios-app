//
//  String+Permutation.swift
//  Interchange
//
//  Created by Steven Masini on 13/07/2017.
//  Copyright © 2017 Steven Masini. All rights reserved.
//

import Foundation

extension String {
    public func permutation() -> Set<String> {
        var set = Set<String>()
        permutation(self, prefix: "", set: &set)
        
        return set
    }
    
    fileprivate func permutation(_ str: String, prefix: String, set: inout Set<String>) {
        if str.characters.count == 0 {
            set.insert(prefix)
        }
        
        for i in str.characters.indices {
            let left = str.substring(to: i)
            let right = str.substring(from: str.index(after: i))
            
            let rem = left + right
            permutation(rem, prefix: prefix + String(str[i]), set: &set)
        }
    }
}
