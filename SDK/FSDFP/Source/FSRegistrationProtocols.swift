//
//  FSRegistrationProtocols.swift
//  FSDFP
//
//  Created by Dean Chang on 5/12/19.
//  Copyright © 2019 Freestar. All rights reserved.
//

import Foundation
import GoogleMobileAds

/**
 * Protocol that informs the delegate of registration status.
 */
@objc(FSRegistrationDelegate)
public protocol FSRegistrationDelegate: NSObjectProtocol {
    /**
     * This method notifies the delegate when the registration was successful.
     * @param identifier A unique ad idenitifier.
     */
    func didRegister(forIdentifier identifier: String)

    /**
     * This method notifies the delegate when the registration has failed.
     * @param identifier A unique ad idenitifier.
     */
    func didFailToRegister(forIdentifier identifier: String)
}

/**
 * Protocol that defines a ad object.
 */
@objc(FSAdObject)
public protocol FSAdObject: NSObjectProtocol {
    /**
     * The ad loader's ad unit ID
     */
    var adUnitId: String? { get }
    /**
     * Freestar unique ad identifier, readonly
     */
    var fsIdentifier: String? { get }
    /**
     * Delegate for Freestar registration
     */
    weak var registrationDelegate: FSRegistrationDelegate? { get set }
    /**
     * This method allows the developer to load an ad request, applies to DFP only.
     * @param request DFP request.
     */
    func load(_ request: GADRequest?)
}

/**
 * Protocol that defines a banner.
 */
@objc(FSBanner)
public protocol FSBanner: FSAdObject {
    /**
     * Ad size (width, height), readonly
     */
    var fsAdSize: CGSize { get }
    /**
     * Refresh rate, defaults to app config setting
     */
    var fsRefreshRate: TimeInterval { get set }
    /**
     * This method allows the developer to pause autoRefresh of an ad.
     */
    func pauseRefresh()
    /**
     * This method allows the developer to resume autoRefresh of a paused ad.  Note:
     * Calling this method will cause the banner to immediately reload.
     */
    func resumeRefresh()
}

/**
 * Protocol that defines an interstitial.
 */
@objc(FSInterstitial)
public protocol FSInterstitial: FSAdObject {
    /**
     * @field ready Returns YES if the interstitial is ready to be displayed.
     */
    var isReady: Bool { get }
    /**
     * This method allows the developer to present an interstitial ad in fullscreen mode until the user dismisses it.
     * @param rootViewController The root view controller is used to present ad click actions. If your application does not use view controllers, pass in nil and your views will be removed from the window to show the interstitial, and restored when done.
     * @note This has no effect unless isReady returns YES.
     */
    func present(fromRootViewController rootViewController: UIViewController?)
}
