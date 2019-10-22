//
//  Collection+Extensions.swift
//  FSDFP
//
//  Created by Dean Chang on 5/13/19.
//  Copyright © 2019 Freestar. All rights reserved.
//

import Foundation

extension Dictionary {
    mutating func merge(dict: [Key: Value]) {
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}

extension Array {
    public func toDictionary<Key: Hashable>(with selectKey: (Element) -> Key) -> [Key: Element] {
        var dict = [Key: Element]()
        for element in self {
            dict[selectKey(element)] = element
        }
        return dict
    }
}
