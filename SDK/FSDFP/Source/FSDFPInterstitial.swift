//
//  FSDFPInterstitial.swift
//  FSDFP
//
//  Created by Dean Chang on 9/20/19.
//  Copyright © 2019 Freestar. All rights reserved.
//

import Foundation
import GoogleMobileAds


@objc(FSDFPInterstitial)
open class FSDFPInterstitial: DFPInterstitial, GADInterstitialDelegate {
    @objc public private(set) var fsIdentifier:String?
    @objc public weak var registrationDelegate:FSRegistrationDelegate?
    @objc public var isRegistered: Bool = false
    private var fsEventHandler:FSAdEventHandler?
    
    public override init(adUnitID: String) {
        super.init(adUnitID: adUnitID)
    }
    
    @objc public convenience init(eventHandler: FSAdEventHandler?, adUnitId: String) {
        self.init(adUnitID: adUnitId)
        fsEventHandler = eventHandler
        delegate = self
    }

    // MARK: overriden methods
    @objc open override func load(_ request: GADRequest?) {
        guard let request = request else {
            return
        }
        
        Utils.shared.removeHBKeywords(request: request as? DFPRequest)
        Utils.shared.validateAndAttachKeywords(request: request as? DFPRequest, identifier: fsIdentifier)
        super.load(request)
    }
    
    // MARK: GADInterstitialDelegate
    
    public func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        guard let _ = fsEventHandler else { return }
        fsEventHandler!(#function, [String.eventInterstitialKey : ad])
    }
    
    public func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        guard let _ = fsEventHandler else { return }
        fsEventHandler!(#function, [String.eventInterstitialKey : ad, String.eventErrorKey : error])
    }
    
    public func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        guard let _ = fsEventHandler else { return }
        fsEventHandler!(#function, [String.eventInterstitialKey : ad])
    }
    
    public func interstitialDidFail(toPresentScreen ad: GADInterstitial) {
        guard let _ = fsEventHandler else { return }
        fsEventHandler!(#function, [String.eventInterstitialKey : ad])
    }
    
    public func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        guard let _ = fsEventHandler else { return }
        fsEventHandler!(#function, [String.eventInterstitialKey : ad])
    }
    
    public func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        guard let _ = fsEventHandler else { return }
        fsEventHandler!(#function, [String.eventInterstitialKey : ad])
    }
    
    public func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
        guard let _ = fsEventHandler else { return }
        fsEventHandler!(#function, [String.eventInterstitialKey : ad])
    }    
}
