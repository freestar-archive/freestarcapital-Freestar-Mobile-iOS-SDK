//
//  FSDFPBannerView.swift
//  FSDFP
//
//  Created by Dean Chang on 9/19/19.
//  Copyright © 2019 Freestar. All rights reserved.
//

import Foundation
import GoogleMobileAds
import FSCommon

@objc(FSDFPBannerView)
open class FSDFPBannerView: DFPBannerView, GADBannerViewDelegate {
    
    // MARK: public properties
    @objc public private(set) var fsIdentifier:String?
    @objc public var paused: Bool = false
    @objc public weak var registrationDelegate:FSRegistrationDelegate?
    @objc public var isRegistered: Bool = false
    
    // MARK: private properties
    private var fsTimer:FSWeakGCDTimer?
    private var fsEventHandler:FSAdEventHandler?
    private var fsRequest:GADRequest?
    private var _fsRefreshRate: TimeInterval = TimeInterval.bannerRefreshIntervalDefault
    
    // MARK: computed properties
    @objc public var fsAdSize: CGSize {
        get {
            return adSize.size
        }
    }
    
    @objc public private(set) var adUnitId:String? {
        get {
            return super.adUnitID
        }
        
        set(newValue) {
            super.adUnitID = newValue
        }
    }
    
    @objc public var fsRefreshRate:TimeInterval {
        get {
            return _fsRefreshRate
        }
        
        set(newValue) {
            guard newValue.validateForBanner() else {
                return
            }
            fsTimer = FSWeakGCDTimer.scheduledTimer(withTimeInterval: newValue,
                                                    target: self,
                                                    selector: #selector(self.fsReload),
                                                    userInfo: nil,
                                                    repeats: true,
                                                    dispatchQueue: FSDFPBannerView.fsQueue)
            _fsRefreshRate = newValue
        }
    }
    
    // MARK: static dispatch queue
    static var fsQueue: DispatchQueue = {
        var queue = DispatchQueue(label: "io.freestar.mobile.queue.dfpbanner")
        return queue
    }()
    
    deinit {
        // timer cleanup
        guard let timer = fsTimer else {
            return
        }
        timer.invalidate()
    }
    
    init(_ size: GADAdSize) {
        if (size.validate()) {
            super.init(adSize: size)
            validAdSizes = [NSValueFromGADAdSize(size)]
        } else {
            // default to banner if ad size is invalid
            super.init(adSize: kGADAdSizeBanner)
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        paused = aDecoder.decodeObject(forKey: "paused") as! Bool
        isRegistered = aDecoder.decodeObject(forKey: "isRegistered") as! Bool
        _fsRefreshRate = aDecoder.decodeObject(forKey: "fsRefreshRate") as! TimeInterval
        fsEventHandler = aDecoder.decodeObject(forKey: "fsEventHandler") as? FSAdEventHandler
        registrationDelegate = aDecoder.decodeObject(forKey: "registrationDelegate") as? FSRegistrationDelegate
        fsIdentifier = aDecoder.decodeObject(forKey: "fsIdentifier") as? String
        fsTimer = aDecoder.decodeObject(forKey: "fsTimer") as? FSWeakGCDTimer
        fsRequest = aDecoder.decodeObject(forKey: "fsRequest") as? GADRequest
        
        super.init(coder: aDecoder)
    }
    
    // MARK: convenience constructor
    @objc public convenience init(eventHandler: FSAdEventHandler?, size: GADAdSize) {
        self.init(size)
        fsEventHandler = eventHandler
        isAutoloadEnabled = false
        delegate = self
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public override init(adSize: GADAdSize, origin: CGPoint) {
        super.init(adSize: adSize, origin: origin)
    }
    
    // MARK: overriden methods
    @objc open override func load(_ request: GADRequest?) {
        guard let request = request else {
            return
        }
        
        Utils.shared.removeHBKeywords(request: request as? DFPRequest)
        Utils.shared.validateAndAttachKeywords(request: request as? DFPRequest, identifier: fsIdentifier)
        super.load(request)
        fsRequest = request
        if fsTimer == nil {
            // initialize timer
            fsRefreshRate = TimeInterval.bannerRefreshIntervalDefault
        }
    }
    
    // MARK: overriden properties
    open override var adSize: GADAdSize {
        // ensure valid ad size
        set {
            if adSize.validate() {
                super.adSize = adSize
            } else {
                assertionFailure("Cannot instantiate ad object due to invalid ad size: \(NSStringFromGADAdSize(adSize))")
            }
        }
        get {
            return super.adSize
        }
    }
    
    // MARK: refresh setter
    @objc public func setFsRefreshRate(_ refreshRate: TimeInterval, sender: Any?) {
        // only set refresh rate if it hasn't been set
        guard _fsRefreshRate == TimeInterval.bannerRefreshIntervalDefault
            && refreshRate.validateForBanner() else {
                return
        }
        fsRefreshRate = refreshRate
    }
    
    static func validate(_ refreshRate: TimeInterval) -> Bool {
        return refreshRate < TimeInterval.bannerRefreshIntervalMax && refreshRate
            > TimeInterval.bannerRefreshIntervalMin
    }
    
    // MARK: pause / refresh
    @objc public func pauseRefresh() {
        paused = true
    }
    
    @objc public func resumeRefresh() {
        paused = false
        guard let timer = fsTimer else {
            return
        }
        timer.fire()
    }
    
    // MARK: internal reload
    @objc func fsReload() {
        var skipReload = false
        if Thread.isMainThread {
            // only allow reload if view is in window
            if superview == nil {
                skipReload = true
            }
        } else {
            weak var weakSelf = self
            DispatchQueue.main.sync(execute: {
                let strongSelf = weakSelf
                if strongSelf?.superview == nil {
                    skipReload = true
                }
            })
        }
        
        if skipReload || paused {
            return
        }
        
        // only allow reload if loadRequest was called
        if let _ = adUnitID, let request = fsRequest  {
            DispatchQueue.main.async(execute: {
                Utils.shared.removeHBKeywords(request: request as? DFPRequest)
                Utils.shared.validateAndAttachKeywords(request: request as? DFPRequest, identifier: self.fsIdentifier)
                super.load(request)
            })
        }
    }
    
    // MARK: GADBannerViewDelegate
    public func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        self.resize(bannerView.adSize)
        guard let _ = fsEventHandler else { return }
        fsEventHandler!(#function, [String.eventBannerViewKey : bannerView])
    }
    
    public func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        guard let _ = fsEventHandler else { return }
        fsEventHandler!(#function, [String.eventBannerViewKey : bannerView, String.eventErrorKey : error])
    }
    
    public func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        guard let _ = fsEventHandler else { return }
        fsEventHandler!(#function, [String.eventBannerViewKey : bannerView])
    }
    
    public func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        guard let _ = fsEventHandler else { return }
        fsEventHandler!(#function, [String.eventBannerViewKey : bannerView])
    }
    
    public func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        guard let _ = fsEventHandler else { return }
        fsEventHandler!(#function, [String.eventBannerViewKey : bannerView])
    }
    
    public func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        guard let _ = fsEventHandler else { return }
        fsEventHandler!(#function, [String.eventBannerViewKey : bannerView])
    }
}

