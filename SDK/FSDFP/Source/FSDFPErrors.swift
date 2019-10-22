//
//  DFPErrors.swift
//  FSDFP
//
//  Created by Dean Chang on 4/23/19.
//  Copyright © 2019 Freestar. All rights reserved.
//

import Foundation

enum FSDFPErrors : Error {
    case BannerInstantiationException(String)
    case PrebidFrameworkMissing(String)
}
