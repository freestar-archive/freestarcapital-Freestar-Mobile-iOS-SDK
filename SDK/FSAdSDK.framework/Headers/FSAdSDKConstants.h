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
static DFPEventNameBanner const DFPEventNameBannerAdViewDidReceiveAd = @"adViewDidReceiveAd:";
static DFPEventNameBanner const DFPEventNameBannerAdViewDidFailToReceiveAd = @"adView:didFailToReceiveAdWithError:";
static DFPEventNameBanner const DFPEventNameBannerAdViewWillPresentFullScreen = @"adViewWillPresentScreen:";
static DFPEventNameBanner const DFPEventNameBannerAdViewWillDismissScreen = @"adViewWillDismissScreen:";
static DFPEventNameBanner const DFPEventNameBannerAdViewDidDismissScreen = @"adViewDidDismissScreen:";
static DFPEventNameBanner const DFPEventNameBannerAdViewWillLeaveApplication = @"adViewWillLeaveApplication:";

// DFP interstitial
typedef NSString *const DFPEventNameInterstitial NS_STRING_ENUM;
static DFPEventNameInterstitial const DFPEventNameInterstitialDidReceiveAd = @"interstitialDidReceiveAd:";
static DFPEventNameInterstitial const DFPEventNameInterstitialDidFailToReceiveAdWithError = @"interstitial:didFailToReceiveAdWithError:";
static DFPEventNameInterstitial const DFPEventNameInterstitialWillPresentScreen = @"interstitialWillPresentScreen:";
static DFPEventNameInterstitial const DFPEventNameInterstitialDidFailToPresentScreen = @"interstitialDidFailToPresentScreen:";
static DFPEventNameInterstitial const DFPEventNameInterstitialWillDismissScreen = @"interstitialWillDismissScreen:";
static DFPEventNameInterstitial const DFPEventNameInterstitialDidDismissScreen = @"interstitialDidDismissScreen:";
static DFPEventNameInterstitial const DFPEventNameInterstitialWillLeaveApplication = @"interstitialWillLeaveApplication:";

#endif /* FSAdSDKConstants_h */
