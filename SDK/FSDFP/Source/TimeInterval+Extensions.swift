//
//  TimeInterval+Extensions.swift
//  FSDFP
//
//  Created by Dean Chang on 5/17/19.
//  Copyright © 2019 Freestar. All rights reserved.
//

import Foundation

extension TimeInterval {
    func validateForBanner() -> Bool {
    return self < TimeInterval.bannerRefreshIntervalMax
        && self > TimeInterval.bannerRefreshIntervalMin
    }
}
