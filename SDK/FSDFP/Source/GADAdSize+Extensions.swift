//
//  GADAdSize+Extensions.swift
//  FSDFP
//
//  Created by Dean Chang on 5/16/19.
//  Copyright © 2019 Freestar. All rights reserved.
//

import Foundation
import GoogleMobileAds

extension GADAdSize {
    // MARK: size validation
    func validate() -> Bool {
        var validSize = false
        validSize = IsGADAdSizeValid(self)
        if validSize {
            // weed out invalid default ad sizes
            let invalidAdSizeMin: GADAdSize = GADAdSizeFromCGSize(CGSize.zero)
            let invalidAdSizeMax: GADAdSize = GADAdSizeFromCGSize(CGSize(width: 1000, height: 1000))
            let invalidAdSizeVMax: GADAdSize = GADAdSizeFromCGSize(CGSize(width: 0, height: 1000))
            let invalidAdSizeHMax: GADAdSize = GADAdSizeFromCGSize(CGSize(width: 1000, height: 0))
            let invalidAdSizeVMin: GADAdSize = GADAdSizeFromCGSize(CGSize(width: 0, height: 1))
            let invalidAdSizeHMin: GADAdSize = GADAdSizeFromCGSize(CGSize(width: 1, height: 0))
            if GADAdSizeEqualToSize(self, invalidAdSizeMin) || GADAdSizeEqualToSize(self, invalidAdSizeMax) || GADAdSizeEqualToSize(self, invalidAdSizeVMax) || GADAdSizeEqualToSize(self, invalidAdSizeHMax) || GADAdSizeEqualToSize(self, invalidAdSizeVMin) || GADAdSizeEqualToSize(self, invalidAdSizeHMin) {
                validSize = false
            }
        }
        return validSize
    }
}
