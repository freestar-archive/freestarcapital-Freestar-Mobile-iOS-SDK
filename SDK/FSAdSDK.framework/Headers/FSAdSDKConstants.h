//
//  FSAdSDKConstants.h
//  FSAdSDK
//
//  Created by Dean Chang on 5/1/18.
//  Copyright © 2018 Freestar. All rights reserved.
//

#ifndef FSAdSDKConstants_h
#define FSAdSDKConstants_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// DFP banner
typedef NSString *DFPEventNameBanner NS_STRING_ENUM;
static DFPEventNameBanner const DFPEventNameBannerAdViewDidReceiveAd = @"adViewDidReceiveAd(_:)";
static DFPEventNameBanner const DFPEventNameBannerAdViewDidFailToReceiveAd = @"adView(_:didFailToReceiveAdWithError:)";
static DFPEventNameBanner const DFPEventNameBannerAdViewWillPresentFullScreen = @"adViewWillPresentScreen(_:)";
static DFPEventNameBanner const DFPEventNameBannerAdViewWillDismissScreen = @"adViewWillDismissScreen(_:)";
static DFPEventNameBanner const DFPEventNameBannerAdViewDidDismissScreen = @"adViewDidDismissScreen(_:)";
static DFPEventNameBanner const DFPEventNameBannerAdViewWillLeaveApplication = @"adViewWillLeaveApplication(_:)";

// DFP interstitial
typedef NSString *const DFPEventNameInterstitial NS_STRING_ENUM;
static DFPEventNameInterstitial const DFPEventNameInterstitialDidReceiveAd = @"interstitialDidReceiveAd(_:)";
static DFPEventNameInterstitial const DFPEventNameInterstitialDidFailToReceiveAdWithError = @"interstitial(_:didFailToReceiveAdWithError:)";
static DFPEventNameInterstitial const DFPEventNameInterstitialWillPresentScreen = @"interstitialWillPresentScreen(_:)";
static DFPEventNameInterstitial const DFPEventNameInterstitialDidFailToPresentScreen = @"interstitialDidFail(toPresentScreen:)";
static DFPEventNameInterstitial const DFPEventNameInterstitialWillDismissScreen = @"interstitialWillDismissScreen(_:)";
static DFPEventNameInterstitial const DFPEventNameInterstitialDidDismissScreen = @"interstitialDidDismissScreen(_:)";
static DFPEventNameInterstitial const DFPEventNameInterstitialWillLeaveApplication = @"interstitialWillLeaveApplication(_:)";

#endif /* FSAdSDKConstants_h */
