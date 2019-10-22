//
//  Constants.swift
//  FSDFP
//
//  Created by Dean Chang on 4/23/19.
//  Copyright © 2019 Freestar. All rights reserved.
//

import Foundation

public typealias FSAdEventHandler = @convention(block) (_ methodName: String, _ params: [ String : Any]) -> Void

extension String {
    static let eventBannerViewKey = "bannerView"
    static let eventInterstitialKey = "interstitial"
    static let eventErrorKey = "error"
    static let PB_GDPR_ConsentString = "kPBGDPRConsentString"
    static let PB_GDPR_SubjectToConsent = "kPBGdprSubjectToConsent"
    static let IAB_GDPR_SubjectToConsent = "IABConsent_SubjectToGDPR"
    static let IAB_GDPR_ConsentString = "IABConsent_ConsentString"
    static let EMPTY_String = ""
    static let kIFASentinelValue = "00000000-0000-0000-0000-000000000000"
}

extension TimeInterval {
    static let bannerRefreshIntervalMax = 60.0 * 60.0
    static let bannerRefreshIntervalMin = 15.0
    static let bannerRefreshIntervalDefault = 25.11
}
