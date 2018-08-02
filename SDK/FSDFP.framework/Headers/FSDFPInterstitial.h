//
//  FSDFPInterstitial.h
//  FSInterstitial
//
//  Created by Dean Chang on 7/16/18.
//  Copyright © 2018 Freestar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMobileAds/DFPInterstitial.h>

@protocol FSRegistrationDelegate;

@interface FSDFPInterstitial : DFPInterstitial <GADInterstitialDelegate>

@property (nonatomic, copy) NSString *fsIdentifier;
@property (nonatomic, weak) id<FSRegistrationDelegate> registrationDelegate;

- (instancetype)initWithEventHandler:(void(^)(NSString *__nonnull methodName, NSDictionary<NSString*, id> *__nonnull params))eventHandler
                            adUnitId:(NSString*)adUnitId;

@end
